# Use Case Template

## Metadata

```yaml
id: UC-XXX
title: "Título do Caso de Uso"
version: 1.0
status: draft # draft, review, approved, implemented
priority: medium # low, medium, high, critical
complexity: medium # low, medium, high
effort: medium # low, medium, high

stakeholders:
  owner: "Nome do Product Owner"
  team: "Nome do Time"
  client: "Nome do Cliente/Área"

dates:
  created: YYYY-MM-DD
  updated: YYYY-MM-DD
  approved: YYYY-MM-DD
  implemented: YYYY-MM-DD
```

## 1. Descrição

### 1.1 Objetivo
Descreva o objetivo principal deste caso de uso em um parágrafo conciso.

### 1.2 Contexto
Explique o contexto em que este caso de uso se aplica, incluindo:
- Situação atual
- Problema a ser resolvido
- Benefícios esperados

### 1.3 Escopo
Defina claramente o que está e o que não está no escopo deste caso de uso.

#### 1.3.1 No Escopo
- Item 1
- Item 2
- Item 3

#### 1.3.2 Fora do Escopo
- Item 1
- Item 2
- Item 3

## 2. Atores

### 2.1 Atores Principais
- **Ator 1**: Descrição e responsabilidades
- **Ator 2**: Descrição e responsabilidades

### 2.2 Atores Secundários
- **Ator 3**: Descrição e responsabilidades
- **Ator 4**: Descrição e responsabilidades

## 3. Pré-condições
1. Pré-condição 1
2. Pré-condição 2
3. Pré-condição 3

## 4. Fluxo Principal

### 4.1 Diagrama
```mermaid
sequenceDiagram
    Actor->>System: Ação 1
    System->>Database: Validação
    Database-->>System: Resultado
    System-->>Actor: Resposta
```

### 4.2 Passos
1. Passo 1
   - Detalhes e regras
   - Validações necessárias
2. Passo 2
   - Detalhes e regras
   - Validações necessárias
3. Passo 3
   - Detalhes e regras
   - Validações necessárias

## 5. Fluxos Alternativos

### 5.1 Fluxo Alternativo 1
1. Condição de ativação
2. Passos alternativos
3. Retorno ao fluxo principal

### 5.2 Fluxo Alternativo 2
1. Condição de ativação
2. Passos alternativos
3. Retorno ao fluxo principal

## 6. Fluxos de Exceção

### 6.1 Exceção 1
1. Condição de erro
2. Tratamento da exceção
3. Resultado esperado

### 6.2 Exceção 2
1. Condição de erro
2. Tratamento da exceção
3. Resultado esperado

## 7. Pós-condições
1. Pós-condição 1
2. Pós-condição 2
3. Pós-condição 3

## 8. Requisitos Especiais

### 8.1 Requisitos de Performance
- Requisito 1
- Requisito 2

### 8.2 Requisitos de Segurança
- Requisito 1
- Requisito 2

### 8.3 Requisitos de Usabilidade
- Requisito 1
- Requisito 2

## 9. Critérios de Aceitação

### 9.1 Critérios Funcionais
```gherkin
Cenário: Nome do cenário
  Dado que [contexto]
  Quando [ação]
  Então [resultado esperado]
```

### 9.2 Critérios Não Funcionais
1. Critério 1
2. Critério 2
3. Critério 3

## 10. Informações Adicionais

### 10.1 Mockups e Protótipos
[Links ou imagens dos mockups/protótipos]

### 10.2 Referências
- Referência 1
- Referência 2

### 10.3 Notas de Implementação
```yaml
implementation:
  technologies:
    - Tech 1
    - Tech 2
  dependencies:
    - Dep 1
    - Dep 2
  considerations:
    - Consideração 1
    - Consideração 2
```

## 11. Histórico de Revisões

| Versão | Data       | Autor | Mudanças |
|--------|------------|-------|----------|
| 1.0    | YYYY-MM-DD | @user | Criação inicial |

## 12. Aprovações

| Papel | Nome | Data | Assinatura |
|-------|------|------|------------|
| Product Owner | | | |
| Tech Lead | | | |
| Arquiteto | | | |
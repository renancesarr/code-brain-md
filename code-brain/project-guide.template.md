# PROJECT GUIDE — <Nome do Projeto>

> Este template referencia `AGENTS.md` e `code-brain/guidelines/pipeline-insight-usecase-todo.md`.
> Preencha sempre com base em insights (`IN-XXXX`) e use-cases (`UC-XXXX`) rastreáveis.

## 1. Introduction

- **Visão geral**: descreva o problema e o objetivo estratégico.
- **Resultados esperados**: liste benefícios mensuráveis (ex.: documentação viva, automação, rastreabilidade).
- **Escopo inicial**: limite o que faz parte do projeto nesta fase.

## 2. Features

### 2.1 Requisitos Funcionais
1. `[UC-0001]` Descreva a funcionalidade e seu impacto.
2. `[UC-0002]` ...

### 2.2 Requisitos Não-Funcionais
1. Performance/SLAs
2. Consistência de documentação
3. Segurança / compliance

## 3. MVP Roadmap

Explique como o projeto se divide em MVPs incrementais.

### 3.1 MVP-1 — <nome>
- **Objetivo**:
- **Features incluídas** (listar `UC-XXXX`):
- **Critérios de aceite**:

### 3.2 MVP-2 — <nome>
- ...

> Adicione mais MVPs conforme necessário.

## 4. Arquitetura

### 4.1 Componentes Principais
1. **Context Manager** — responsabilidades / integrações.
2. **Pipeline Cognitivo** — relação INSIGHT→USE-CASE→TO-DO.
3. **Template Engine** — geração/validação de documentos.
4. **Integration Layer** — Git, CI/CD, métricas.

### 4.2 Tecnologias
- Linguagens, frameworks, ferramentas de validação.
- Dependências externas e políticas de segurança.

## 5. KPI e Métricas

### 5.1 Métricas de Processo
- Tempo por use-case, qualidade de documentação, taxa de retrabalho etc.

### 5.2 Métricas de Resultado
- Onboarding, custo cognitivo, qualidade percebida.

### 5.3 Métricas de Impacto
- Satisfação da equipe, velocidade de entrega, manutenção.

## 6. Governança e Fluxo Operacional

- **Pipeline**: referencie etapas do guideline INSIGHT→USE-CASE→TO-DO.
- **Validações**: script `code-brain/scripts/validate-docs.sh`, testes específicos.
- **Documentação obrigatória**: logs IA, backlog anatômico, templates aplicados.

---

> Sempre atualize este guia quando novos MVPs, métricas ou componentes forem aprovados.

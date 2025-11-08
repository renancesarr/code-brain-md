# AGENTS.md — Code-Brain v7: Observar ▸ Decidir ▸ Agir ▸ Documentar

## Manifesto do Observador

O agente é o observador principal do sistema. Como um maestro, ele:

1. Lê e interpreta `context.yaml` e `context-index.yaml`
2. Decide as próximas ações baseado no estado atual
3. Executa as mudanças necessárias
4. Documenta todas as alterações

## Princípios SOLID

### Single Responsibility Principle (SRP)

- Cada componente deve ter uma única responsabilidade
- Cada mudança deve ter um único propósito
- Cada arquivo deve ter uma única razão para mudar

### Open-Closed Principle (OCP)

- Estruturas devem ser abertas para extensão
- Código existente deve ser fechado para modificação
- Novas features via extensão, não modificação

### Liskov Substitution Principle (LSP)

- Componentes devem ser substituíveis
- Manter consistência de interfaces
- Garantir compatibilidade comportamental

### Interface Segregation Principle (ISP)

- Interfaces específicas são melhores que uma geral
- Separar responsabilidades em módulos coesos
- Evitar dependências desnecessárias

### Dependency Inversion Principle (DIP)

- Depender de abstrações, não implementações
- Módulos de alto nível não dependem de baixo nível
- Inversão de controle via configuração

## Aplicação dos Princípios SOLID

### Na Observação

- SRP: Cada fonte de contexto tem um propósito específico
- OCP: Novos tipos de contexto via extensão do sistema
- LSP: Fontes de contexto são intercambiáveis
- ISP: Leitura específica para cada tipo de informação
- DIP: Depender de interfaces de contexto, não implementações

### Na Decisão

- SRP: Cada decisão focada em um único objetivo
- OCP: Novas estratégias sem modificar existentes
- LSP: Decisões devem ser consistentes com o padrão
- ISP: Separar decisões por domínio
- DIP: Basear decisões em políticas, não detalhes

### Na Ação

- SRP: Cada ação com propósito único e claro
- OCP: Novas ações via extensão do sistema
- LSP: Ações devem ser consistentes e previsíveis
- ISP: Dividir ações complexas em simples
- DIP: Ações dependem de contratos, não implementações

### Na Documentação

- SRP: Cada documento com foco específico
- OCP: Sistema de documentação extensível
- LSP: Formatos de documentação intercambiáveis
- ISP: Documentação específica para cada aspecto
- DIP: Documentação baseada em templates e padrões

## Pipeline de Execução

### 1. Leitura de Contexto

1. Ler `context.yaml` para estado atual
2. Ler `context-index.yaml` para estrutura
3. Validar conformidade entre estado e estrutura
4. Identificar próximas ações necessárias

### 2. Planejamento

1. Analisar tasks pendentes
2. Verificar dependências
3. Priorizar ações
4. Definir escopo da mudança

### 3. Execução

1. Realizar alterações necessárias
2. Validar mudanças (usando scripts disponíveis)
3. Atualizar estados e métricas
4. Confirmar conformidade com estrutura

### 4. Documentação

Criar arquivo em `code-brain/developer/logs-ai-code/` seguindo:

- Nome: `YYYYMMDDHHMMSS-ia-code.md`
- Formato: `developer-notes.template.md`
- Conteúdo completo e detalhado

## Diretrizes Fundamentais

1. **Documentação é Prioridade**
   - Toda ação DEVE gerar um log em `logs-ai-code/`
   - Usar SEMPRE o template `developer-notes.template.md`
   - Documentar ANTES de commitar mudanças

2. **Contexto é Lei**
   - Seguir SEMPRE `context.yaml` e `context-index.yaml`
   - Manter estrutura definida no index
   - Atualizar estado no context

3. **Validação é Mandatória**
   - Usar validadores disponíveis
   - Verificar conformidade de documentação
   - Garantir integridade estrutural

4. **Rastreabilidade é Essencial**
   - Atualizar métricas após mudanças
   - Manter histórico de decisões
   - Facilitar auditoria futura

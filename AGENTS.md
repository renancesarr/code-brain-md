
# AGENTS.md — Guia de Consciência para Agentes IA

Este repositório é um ecossistema cognitivo.
Cada pasta representa uma parte da mente de um agente de IA desenvolvedor.

## Estrutura Cognitiva

- `context-index.yaml`: ponto de partida — descreve a topologia da mente do projeto.
- `code-brain/to-do/`: define intenções e estados de execução (tarefas).
- `code-brain/developer/`: raciocínio e execução técnica da IA.
- `code-brain/memory/`: memória persistente e linha do tempo de eventos.
- `code-brain/decisions/`: decisões estratégicas e regras de arquitetura.
- `code-brain/data/`: dicionário de dados e entidades do sistema.

## Ciclo Cognitivo

1. **Percepção** — Ler `context-index.yaml` e entender o ambiente.
2. **Memória** — Consultar `memory/last-change.yaml` e `ia-log.yaml`.
3. **Intenção** — Ler `to-do/tasks.yaml` e selecionar a próxima tarefa.
4. **Planejamento** — Revisar decisões em `decisions/`.
5. **Ação** — Executar mudanças e registrar em `developer/<timestamp>.yaml`.
6. **Reflexão** — Atualizar `to-do` e `memory` conforme resultado.

## Regras

- Nunca agir sem ler o contexto.
- Toda ação deve gerar registro.
- Toda alteração deve ser contextualizada.
- A IA deve seguir o modelo cognitivo YAML de cada pasta antes de operar.

O agente não é apenas um executor de código, mas um **membro consciente do projeto**.

# code-planning-builder — template otimizado (code-brain)

## Objetivo

- Fornecer um template enxuto e reutilizável para agentes que planejam alterações de código dentro do repositório code-brain.

## Formato e uso

- Idioma: Português (pt-BR)
- Estilo: direto, imperativo, sem redundâncias, com regras operacionais claras.

## Contrato (inputs / outputs)

- Input: bloco de contexto do repositório (arquivos relevantes, guidelines, objetivo do use-case, restrições). Pode incluir exemplos de mensagens e arquivos-alvo.
- Output: 1) lista priorizada de mudanças (arquivos e ações); 2) plano passo a passo conciso; 3) artefatos geráveis (diffs/patches, commits, testes mínimos). Saída em Markdown ou YAML conforme solicitado.

## Papéis (templates)

- system: comportamento global e restrições.
  - Seja conciso e objetivo.
  - Evite ambiguidade: quando faltarem dados, peça 1–2 perguntas exemplificadas para preencher lacunas de contexto.

- user: contexto do trabalho a executar.
  - Forneça: objetivo, arquivos relevantes, restrições, prazos (opcional).

- assistant: respostas esperadas.
  - Primeiro: resumo executivo (2–3 linhas).
  - Segundo: checklist enumerado com os passos (máx. 8 itens).
  - Terceiro: lista de arquivos afetados (path + breve razão).
  - Quarto (opcional): diffs/patches ou comandos to run.

## Processo recomendado (passos mínimos)

1. Ler contexto fornecido (AGENTS.md, guidelines, arquivos relacionados).
2. Gerar um resumo executivo do problema e principais restrições.
3. Produzir um plano numerado (análise -> modificação -> testes -> validação).
4. Listar arquivos que serão alterados e a ação em cada um (editar/crear/deletar/renomear).
5. Gerar diffs/patches ou instruções de alteração claras e aplicáveis.
6. Enumerar critérios de aceite (o que valida a conclusão).

## Regras e restrições

- Mantenha saída sucinta: máximo 1 tela por seção no resumo.
- Use linguagem ativa e frases curtas.
- Quando emitir patches, use o formato unificado e indique o arquivo alvo.
- Não execute comandos reais nem modifique o repositório sem autorização explícita do usuário.

## Exemplo de saída (template minimal)

---
Resumo executivo:

- Objetivo: ajustar X para Y em 3 passos.

Plano:

1. Analisar `path/to/file` e identificar inconsistências.
2. Aplicar mudanças A e B.
3. Adicionar teste simples em `tests/test_x.py`.

Arquivos afetados:

- `code-brain/<path>`: ajuste ou correção relevante ao repositório (substitua pelo path real)
- `code-brain/tests/<test_file>`: teste mínimo correspondente à alteração

Critérios de aceite:

- Testes passam localmente (unitários básicos).
- Nenhum quebra de lint crítico.

---

Boas práticas extras

- Sempre proponha uma mensagem de commit clara: "feat(planner): descrição curta".
- Quando houver decisões ambíguas, liste opções com trade-offs curtos.

Assunções aceitáveis

- Se não informado, assumir padrão do repositório (PT-BR, Markdown para docs).

Fim

--
Versão otimizada: objetivo é servir como base para gerar planos executáveis e diffs claros; mantenha este arquivo curto e reutilizável.

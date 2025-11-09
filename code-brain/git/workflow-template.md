# Workflow Template — Git do Code-Brain

> Referências diretas: `code-brain/guidelines/git/guidelines.md`,
> `code-brain/guidelines/git/commit-convention.md`,
> `code-brain/guidelines/preflight.md`, `code-brain/guidelines/preflight.sh`,
> `code-brain/scripts/validate-docs.sh`.

## 1. Convenções Obrigatórias

| Item          | Regra                                                                 | Exemplo                         |
| ------------- | --------------------------------------------------------------------- | ------------------------------- |
| Branch        | `feature/UC-XXX/TXXXX` derivada de `develop`                          | `feature/UC-003/T0005`          |
| Commit        | `<type>(<context>): <descrição>`                                      | `feat(context): sincroniza index` |
| PR Title      | `[UC-XXX] Descrição`                                                  | `[UC-003] Documenta templates`  |
| Template PR   | `code-brain/guidelines/git/pr-template.md`                            | sempre obrigatório              |
| Checks        | `code-brain/scripts/validate-docs.sh`, testes do repo, `preflight.sh` | ver Seção 3                     |

> **Nunca** faça push em `develop`/`main` sem PR aprovada. Toda execução deve ser registrada em log IA.

## 2. Fluxo Operacional

```bash
# 1. Preparar branch
git checkout develop && git pull
git checkout -b feature/UC-XXX/TXXXX   # use IDs reais do backlog

# 2. Desenvolver
# edite apenas arquivos necessários; mantenha commits atômicos

# 3. Validar localmente
code-brain/scripts/validate-docs.sh    # YAML + Markdown
npm test || pytest                     # conforme projeto
code-brain/guidelines/preflight.sh commit "feat(scope): descrição"

# 4. Commit
git add <arquivos>
git commit -m "feat(scope): descrição"

# 5. Rebase com develop
git checkout develop && git pull
git checkout feature/UC-XXX/TXXXX
git rebase -i --autosquash develop

# 6. Preflight completo
code-brain/guidelines/preflight.sh push

# 7. Push e PR
git push -u origin feature/UC-XXX/TXXXX
code-brain/guidelines/preflight.sh pr
# abrir PR usando template padrão
```

## 3. Checklist Antes da PR

1. Branch segue exatamente `feature/UC-XXX/TXXXX`.
2. Commits obedecem `type(scope): message` (tipos: feat, fix, docs, style, refactor, test, chore).
3. `code-brain/scripts/validate-docs.sh` executado e registrado no log IA.
4. Testes e linters do repositório rodaram localmente (anexar resultados à PR/log).
5. `code-brain/guidelines/preflight.sh push` e `pr` passaram sem erros.
6. PR usa template oficial e lista `T-XXXX`/`UC-XXXX` impactados.
7. `commands-log` atualizado quando aplicável (ver `code-brain/guidelines/git/commands-log-template.yaml`).

## 4. Pós-Merge

```bash
git checkout develop
git pull
git branch -D feature/UC-XXX/TXXXX
git push origin --delete feature/UC-XXX/TXXXX
code-brain/guidelines/preflight.sh merge
```

Atualize `context.yaml` e `code-brain/to-do/tasks.yaml` com o status da tarefa e registre o número da PR no log IA correspondente.

## 5. Recursos Relacionados

- Convenções gerais: `code-brain/guidelines/git/guidelines.md`
- Commits: `code-brain/guidelines/git/commit-convention.md`
- PR template: `code-brain/guidelines/git/pr-template.md`
- Preflight CLI: `code-brain/guidelines/preflight-dev-guide.md`
- Validação de docs: `code-brain/scripts/validate-docs.sh`

> Este documento é a fonte canônica do fluxo Git. Qualquer alteração deve ser refletida simultaneamente
> nos guidelines Git e registrada em `code-brain/developer/logs-ai-code/`.

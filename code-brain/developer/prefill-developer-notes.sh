#!/usr/bin/env bash
set -euo pipefail

# prefill-developer-notes.sh
# Gera um arquivo de developer notes a partir do template, preenchendo
# informações do repositório (branch, commit, estado) e registrando
# comandos executados.

TEMPLATE="$(dirname "$0")/developer-notes.template.md"
OUTDIR="$(dirname "$0")/logs-ai-code"
mkdir -p "$OUTDIR"

timestamp=$(date -u +"%Y%m%dT%H%M%SZ")
outfile="$OUTDIR/${timestamp}-ia-code.md"

# Repo info
branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "<no-git>")
commit=$(git rev-parse --short HEAD 2>/dev/null || echo "<no-git>")
uncommitted_changes=false
if [ -n "$(git status --porcelain 2>/dev/null || true)" ]; then
  uncommitted_changes=true
fi
# Try to get last push time for upstream branch, fallback to now
if last_push=$(git log -1 --format=%cI @{u} 2>/dev/null || true); then
  : # keep last_push if set
fi
last_push=${last_push:-$(date -u +"%Y-%m-%dT%H:%M:%SZ")}

# Collect outputs for a few helpful commands
git_status_out=$(git status --porcelain 2>/dev/null || true)
git_untracked_count=$(echo "$git_status_out" | wc -l | tr -d ' ')
recent_commits=$(git log -n 5 --pretty=format:"%h %ad %s" --date=iso 2>/dev/null || true)

# Read template and replace tokens inside repo_state block
# We replace lines starting with two spaces followed by the keys
sed -E \
  -e "s/^(\s*)branch: \".*\"/  branch: \"${branch}\"/" \
  -e "s/^(\s*)commit: \".*\"/  commit: \"${commit}\"/" \
  -e "s/^(\s*)uncommitted_changes: .*/  uncommitted_changes: ${uncommitted_changes}/" \
  -e "s/^(\s*)last_push: \".*\"/  last_push: \"${last_push}\"/" \
  "$TEMPLATE" > /tmp/devnotes_prefill.tmp

# Append a generated context section with command outputs
cat >> /tmp/devnotes_prefill.tmp <<EOF

---

## Generated context (auto-filled)

```yaml
commands_recorded:
  - cmd: "git status --porcelain"
    output: |
$(printf "%s\n" "$git_status_out" | sed 's/^/      /')
  - cmd: "git rev-parse --abbrev-ref HEAD"
    output: "${branch}"
  - cmd: "git rev-parse --short HEAD"
    output: "${commit}"
recent_commits:
$(printf "%s\n" "$recent_commits" | sed 's/^/  - "/; s/$/"/')

generated_at: "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
script: "prefill-developer-notes.sh"
```
EOF

mv /tmp/devnotes_prefill.tmp "$outfile"
chmod 0644 "$outfile"

echo "Generated developer notes: $outfile"

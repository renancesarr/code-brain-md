#!/bin/bash
# Validate-docs script for Code-Brain
# Runs YAML + Markdown validation for core documents.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
PY_VALIDATOR="${SCRIPT_DIR}/validate-docs.py"

# Default coverage (executed when no args are passed)
DEFAULT_YAML_FILES=(
    "${PROJECT_ROOT}/context.yaml"
    "${PROJECT_ROOT}/context-index.yaml"
    "${PROJECT_ROOT}/prompt.yaml"
    "${PROJECT_ROOT}/code-brain/to-do/tasks.yaml"
)

DEFAULT_MD_FILES=(
    "${PROJECT_ROOT}/AGENTS.md"
    "${PROJECT_ROOT}/prompt.md"
    "${PROJECT_ROOT}/project-guide.md"
    "${PROJECT_ROOT}/backlog_anatomico_unificado_padronizado.md"
    "${PROJECT_ROOT}/code-brain/developer/developer-notes.template.md"
    "${PROJECT_ROOT}/code-brain/project-guide.template.md"
    "${PROJECT_ROOT}/code-brain/guidelines/pipeline-insight-usecase-todo.md"
)

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

require_deps() {
    local missing=()
    command -v python3 >/dev/null 2>&1 || missing+=("python3")
    python3 -c "import yaml" >/dev/null 2>&1 || missing+=("pyyaml (python3 -m pip install pyyaml)")
    command -v yamllint >/dev/null 2>&1 || missing+=("yamllint (python3 -m pip install --user yamllint)")

    if [ ${#missing[@]} -ne 0 ]; then
        echo -e "${RED}Missing dependencies:${NC}"
        printf '  - %s\n' "${missing[@]}"
        exit 1
    fi
}

run_yaml_checks() {
    local files=("$@")
    [ ${#files[@]} -eq 0 ] && return 0

    echo -e "${YELLOW}YAML validation${NC}"
    yamllint "${files[@]}"
}

run_markdown_checks() {
    local files=("$@")
    [ ${#files[@]} -eq 0 ] && return 0

    echo -e "${YELLOW}Markdown validation${NC}"
    python3 "${PY_VALIDATOR}" "${files[@]}"
}

process_targets() {
    local yaml_targets=()
    local md_targets=()

    for target in "$@"; do
        if [[ "$target" == *.yml || "$target" == *.yaml ]]; then
            yaml_targets+=("$target")
        else
            md_targets+=("$target")
        fi
    done

    run_yaml_checks "${yaml_targets[@]}"
    run_markdown_checks "${md_targets[@]}"
}

main() {
    require_deps

    if [ $# -gt 0 ]; then
        process_targets "$@"
    else
        run_yaml_checks "${DEFAULT_YAML_FILES[@]}"
        run_markdown_checks "${DEFAULT_MD_FILES[@]}"
    fi

    echo -e "${GREEN}All validations completed.${NC}"
}

main "$@"

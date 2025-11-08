#!/bin/bash

# Preflight Check Script para Code-Brain
# Uso: ./preflight.sh [commit|push|pr|merge]

# Configurações
YAML_PARSER="yq"
CONFIG_FILE="guidelines/preflight.yaml"
LOG_FILE="preflight.log"

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Função para logging
log_preflight() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Validar branch name
check_branch_name() {
    current_branch=$(git branch --show-current)
    if [[ ! $current_branch =~ ^feature/UC-[0-9]{3}/T[0-9]{3}$ ]]; then
        echo -e "${RED}❌ Branch name '$current_branch' não segue o padrão${NC}"
        echo -e "${YELLOW}Esperado: feature/UC-XXX/TXXX${NC}"
        return 1
    fi
    echo -e "${GREEN}✓ Branch name válido${NC}"
    return 0
}

# Validar commit message
check_commit_message() {
    message="$1"
    if [[ ! $message =~ ^(feat|fix|docs|style|refactor|test|chore)\(.+\):\ .+$ ]]; then
        echo -e "${RED}❌ Commit message não segue convenção${NC}"
        echo -e "${YELLOW}Esperado: type(scope): message${NC}"
        return 1
    fi
    echo -e "${GREEN}✓ Commit message válida${NC}"
    return 0
}

# Verificar workspace
check_workspace() {
    if [[ -n $(git status -s) ]]; then
        echo -e "${YELLOW}⚠️ Workspace tem alterações não commitadas${NC}"
        return 1
    fi
    echo -e "${GREEN}✓ Workspace limpo${NC}"
    return 0
}

# Verificar testes
check_tests() {
    npm test
    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ Testes falhando${NC}"
        return 1
    fi
    echo -e "${GREEN}✓ Testes passando${NC}"
    return 0
}

# Verificar lint
check_lint() {
    npm run lint
    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ Lint falhou${NC}"
        return 1
    fi
    echo -e "${GREEN}✓ Lint passou${NC}"
    return 0
}

# Verificar cobertura de testes
check_coverage() {
    coverage=$(npm run test:coverage | grep "All files" | awk '{print $4}' | sed 's/%//')
    if [ "$coverage" -lt 80 ]; then
        echo -e "${RED}❌ Cobertura de testes insuficiente: $coverage%${NC}"
        echo -e "${YELLOW}Mínimo requerido: 80%${NC}"
        return 1
    fi
    echo -e "${GREEN}✓ Cobertura de testes OK: $coverage%${NC}"
    return 0
}

# Preflight principal
main() {
    echo "🚀 Iniciando preflight checks..."
    log_preflight "Iniciando preflight: $1"
    
    case "$1" in
        "commit")
            check_branch_name
            check_commit_message "$2"
            check_lint
            ;;
            
        "push")
            check_branch_name
            check_workspace
            check_tests
            check_lint
            check_coverage
            ;;
            
        "pr")
            check_branch_name
            check_workspace
            check_tests
            check_lint
            check_coverage
            ;;
            
        "merge")
            check_workspace
            check_tests
            check_coverage
            ;;
            
        *)
            echo "Uso: $0 [commit|push|pr|merge]"
            exit 1
            ;;
    esac
    
    if [ $? -eq 0 ]; then
        echo -e "\n${GREEN}✅ Preflight checks passaram!${NC}"
        log_preflight "Preflight passou: $1"
        exit 0
    else
        echo -e "\n${RED}❌ Preflight checks falharam!${NC}"
        log_preflight "Preflight falhou: $1"
        exit 1
    fi
}

# Executar
main "$@"
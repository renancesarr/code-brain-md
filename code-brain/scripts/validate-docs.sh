#!/bin/bash
# Validate-docs script for Code-Brain
# Integrates YAML and Markdown validation into the workflow

set -e

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check dependencies
check_dependencies() {
    local missing_deps=()
    
    # Check Python
    if ! command -v python3 &>/dev/null; then
        missing_deps+=("python3")
    fi
    
    # Check pip packages
    if ! python3 -c "import yaml" 2>/dev/null; then
        missing_deps+=("pyyaml (pip install pyyaml)")
    fi
    
    # Check markdownlint
    if ! command -v markdownlint &>/dev/null; then
        missing_deps+=("markdownlint-cli (npm install -g markdownlint-cli)")
    fi
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        echo -e "${RED}Missing dependencies:${NC}"
        printf '%s\n' "${missing_deps[@]/#/  - }"
        exit 1
    fi
}

# Validate a documentation file
validate_doc() {
    local file="$1"
    echo -e "\n${YELLOW}Validating document: ${file}${NC}"
    
    # Run Python validator
    if python3 "${SCRIPT_DIR}/validate-docs.py" "$file"; then
        echo -e "${GREEN}✓ Document validation passed${NC}"
        return 0
    else
        echo -e "${RED}✗ Document validation failed${NC}"
        return 1
    fi
}

# Validate context files
validate_context() {
    echo -e "\n${YELLOW}Validating context files...${NC}"
    
    local context_files=(
        "${PROJECT_ROOT}/context.yaml"
        "${PROJECT_ROOT}/context-index.yaml"
    )
    
    local failed=0
    
    for file in "${context_files[@]}"; do
        echo -e "\nChecking ${file}..."
        if python3 "${SCRIPT_DIR}/validate-docs.py" --yaml-only "$file"; then
            echo -e "${GREEN}✓ Context file validation passed${NC}"
        else
            echo -e "${RED}✗ Context file validation failed${NC}"
            failed=1
        fi
    done
    
    return $failed
}

# Main function
main() {
    # Check dependencies first
    check_dependencies
    
    # Validate context files by default
    validate_context
    
    # If files are specified, validate them
    if [ $# -gt 0 ]; then
        for file in "$@"; do
            if [[ -f "$file" ]]; then
                validate_doc "$file"
            else
                echo -e "${RED}Error: File not found - ${file}${NC}"
                exit 1
            fi
        done
    fi
}

# Run main function with all arguments
main "$@"
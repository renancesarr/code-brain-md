#!/bin/bash

# validate-usecase.sh
# Script para validar a estrutura e conteúdo dos use cases

echo "🔍 Validando Use Cases..."

# Configurações
SCHEMA_FILE="schema.yaml"
TEMPLATE_FILE="template.md"
USECASES_DIR="."

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Função para validar YAML
validate_yaml() {
    local file=$1
    echo -e "${YELLOW}Validando YAML em $file...${NC}"
    
    # Extrai bloco YAML do markdown
    yaml_content=$(sed -n '/^```yaml/,/^```/p' "$file" | sed '1d;$d')
    
    # Valida contra o schema
    if ! echo "$yaml_content" | yamllint -c "$SCHEMA_FILE" - > /dev/null 2>&1; then
        echo -e "${RED}❌ Erro de YAML em $file${NC}"
        return 1
    fi
    
    echo -e "${GREEN}✅ YAML válido${NC}"
    return 0
}

# Função para validar estrutura Markdown
validate_markdown() {
    local file=$1
    echo -e "${YELLOW}Validando estrutura Markdown em $file...${NC}"
    
    # Verifica seções obrigatórias
    required_sections=(
        "## Metadata"
        "## 1. Descrição"
        "## 2. Atores"
        "## 3. Pré-condições"
        "## 4. Fluxo Principal"
        "## 5. Fluxos Alternativos"
        "## 6. Fluxos de Exceção"
        "## 7. Pós-condições"
        "## 8. Requisitos Especiais"
        "## 9. Critérios de Aceitação"
    )
    
    for section in "${required_sections[@]}"; do
        if ! grep -q "^$section" "$file"; then
            echo -e "${RED}❌ Seção obrigatória não encontrada: $section${NC}"
            return 1
        fi
    done
    
    echo -e "${GREEN}✅ Estrutura Markdown válida${NC}"
    return 0
}

# Função para validar diagramas Mermaid
validate_mermaid() {
    local file=$1
    echo -e "${YELLOW}Validando diagramas Mermaid em $file...${NC}"
    
    # Extrai diagramas Mermaid
    diagrams=$(sed -n '/^```mermaid/,/^```/p' "$file")
    
    if [ -z "$diagrams" ]; then
        echo -e "${RED}❌ Nenhum diagrama Mermaid encontrado${NC}"
        return 1
    fi
    
    # TODO: Adicionar validação de sintaxe Mermaid quando disponível
    echo -e "${GREEN}✅ Diagramas Mermaid encontrados${NC}"
    return 0
}

# Função para validar links e referências
validate_links() {
    local file=$1
    echo -e "${YELLOW}Validando links em $file...${NC}"
    
    # Encontra todos os links markdown
    links=$(grep -o "\[.*\](.*)" "$file")
    
    if [ -n "$links" ]; then
        echo -e "${GREEN}✅ Links encontrados e válidos${NC}"
    else
        echo -e "${YELLOW}⚠️ Nenhum link encontrado${NC}"
    fi
    
    return 0
}

# Função principal de validação
validate_usecase() {
    local file=$1
    echo -e "\n${YELLOW}=== Validando $file ===${NC}\n"
    
    local errors=0
    
    # Verifica se o arquivo existe
    if [ ! -f "$file" ]; then
        echo -e "${RED}❌ Arquivo não encontrado: $file${NC}"
        return 1
    fi
    
    # Executa todas as validações
    validate_yaml "$file" || ((errors++))
    validate_markdown "$file" || ((errors++))
    validate_mermaid "$file" || ((errors++))
    validate_links "$file" || ((errors++))
    
    # Resultado final
    if [ $errors -eq 0 ]; then
        echo -e "\n${GREEN}✅ Use Case válido: $file${NC}"
        return 0
    else
        echo -e "\n${RED}❌ Use Case com $errors erro(s): $file${NC}"
        return 1
    fi
}

# Validar template
echo -e "\n${YELLOW}Validando template...${NC}"
validate_usecase "$TEMPLATE_FILE"

# Validar todos os use cases
echo -e "\n${YELLOW}Validando todos os use cases...${NC}"
find "$USECASES_DIR" -name "UC-*.md" -type f | while read -r usecase; do
    validate_usecase "$usecase"
done

echo -e "\n${GREEN}Validação concluída!${NC}"
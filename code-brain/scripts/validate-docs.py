#!/usr/bin/env python3
"""
YAML/Markdown Validator for Code-Brain
Validates YAML blocks in Markdown files and general Markdown syntax
"""

import sys
import re
import yaml
from pathlib import Path
import argparse
import subprocess

class ValidationError(Exception):
    """Custom exception for validation errors"""
    pass

def extract_yaml_block(content):
    """Extract YAML front matter from markdown content"""
    yaml_pattern = r"^---\s*\n(.*?)\n---\s*$"
    match = re.search(yaml_pattern, content, re.MULTILINE | re.DOTALL)
    if match:
        return match.group(1)
    return None

def validate_yaml(content):
    """Validate YAML syntax"""
    try:
        yaml.safe_load(content)
        return True, None
    except yaml.YAMLError as e:
        return False, str(e)

def validate_markdown(file_path):
    """Validate markdown using markdownlint"""
    try:
        result = subprocess.run(
            ['markdownlint', file_path],
            capture_output=True,
            text=True
        )
        if result.returncode != 0:
            return False, result.stdout
        return True, None
    except FileNotFoundError:
        return False, "markdownlint not found. Install with: npm install -g markdownlint-cli"

def validate_file(file_path):
    """Validate both YAML and Markdown in a file"""
    errors = []
    
    # Read file content
    try:
        content = Path(file_path).read_text()
    except Exception as e:
        raise ValidationError(f"Could not read file {file_path}: {str(e)}")

    # Validate YAML if present
    yaml_block = extract_yaml_block(content)
    if yaml_block:
        yaml_valid, yaml_error = validate_yaml(yaml_block)
        if not yaml_valid:
            errors.append(f"YAML validation error: {yaml_error}")

    # Validate Markdown
    md_valid, md_error = validate_markdown(file_path)
    if not md_valid:
        errors.append(f"Markdown validation error: {md_error}")

    return len(errors) == 0, errors

def validate_yaml_file(file_path):
    """Validate a pure YAML file"""
    try:
        content = Path(file_path).read_text()
        valid, error = validate_yaml(content)
        if not valid:
            return False, [f"YAML validation error: {error}"]
        return True, None
    except Exception as e:
        return False, [f"Could not validate YAML file {file_path}: {str(e)}"]

def main():
    parser = argparse.ArgumentParser(description="Validate YAML and Markdown files")
    parser.add_argument(
        "files",
        nargs="+",
        help="Files to validate (supports glob patterns)"
    )
    parser.add_argument(
        "--yaml-only",
        action="store_true",
        help="Only validate YAML syntax"
    )
    args = parser.parse_args()

    exit_code = 0
    for pattern in args.files:
        for file_path in Path().glob(pattern):
            print(f"\nValidating {file_path}...")
            
            try:
                if args.yaml_only or file_path.suffix in ['.yaml', '.yml']:
                    valid, errors = validate_yaml_file(file_path)
                else:
                    valid, errors = validate_file(file_path)

                if not valid:
                    exit_code = 1
                    print("❌ Validation failed:")
                    for error in errors:
                        print(f"  - {error}")
                else:
                    print("✅ Validation passed")
            
            except ValidationError as e:
                exit_code = 1
                print(f"❌ Error: {str(e)}")
            except Exception as e:
                exit_code = 1
                print(f"❌ Unexpected error: {str(e)}")

    sys.exit(exit_code)

if __name__ == "__main__":
    main()
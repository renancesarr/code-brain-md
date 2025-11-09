#!/usr/bin/env python3
"""
YAML/Markdown Validator for Code-Brain
Validates YAML blocks in Markdown files and general Markdown syntax
"""

import sys
import re
import argparse
from pathlib import Path
from typing import Iterable, List, Tuple

import yaml

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

MAX_MD_LINE_LENGTH = 0  # 0 = disabled


def validate_markdown_rules(content: str, file_path: Path) -> Tuple[bool, List[str]]:
    """Basic Markdown linting without external deps."""
    errors: List[str] = []
    lines = content.splitlines()

    # First non-empty line must be a heading
    for line in lines:
        if line.strip():
            if not line.startswith("#"):
                errors.append("First non-empty line must be a Markdown heading (# ...).")
            break

    for idx, line in enumerate(lines, start=1):
        raw = line
        if raw.endswith(" ") or raw.endswith("\t"):
            errors.append(f"Line {idx}: trailing whitespace.")
        if "\t" in raw:
            errors.append(f"Line {idx}: tab character found; use spaces only.")
        if MAX_MD_LINE_LENGTH and len(raw) > MAX_MD_LINE_LENGTH:
            errors.append(
                f"Line {idx}: exceeds {MAX_MD_LINE_LENGTH} characters."
            )

    return (len(errors) == 0), errors

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

    # Validate Markdown rules
    md_valid, md_errors = validate_markdown_rules(content, Path(file_path))
    if not md_valid:
        errors.extend([f"Markdown validation error: {err}" for err in md_errors])

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

def expand_targets(pattern: str) -> Iterable[Path]:
    """Yield concrete paths for a given pattern or explicit path."""
    path = Path(pattern)
    if path.exists() or path.is_absolute():
        yield path
    else:
        # glob handles relative and wildcard patterns
        yield from Path().glob(pattern)


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
        matched = False
        for file_path in expand_targets(pattern):
            matched = True
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

        if not matched:
            exit_code = 1
            print(f"❌ No files matched pattern: {pattern}")

    sys.exit(exit_code)

if __name__ == "__main__":
    main()

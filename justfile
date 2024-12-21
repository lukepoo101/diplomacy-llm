# Shows this help message
help:
    @just --list

# Setup uv, environment variables, and pre-commit hooks
setup: setup-env
    uv self update
    uv sync
    pre-commit install

# Setup environment variables
setup-env:
    #!/usr/bin/env sh
    if [ ! -f ".env" ]; then
        cp .env.example .env
    fi

# Run the main script with all arguments passed through
run *ARGS='--help':
    python diplomacy_llm/main.py {{ARGS}}

# Update pre-commit hooks versions
update-pre-commit:
    pre-commit autoupdate

# Run pre-commit hooks on the currently staged files
lint:
    pre-commit run

# Run pre-commit hooks on tracked files
lint-all:
    pre-commit run --all-files

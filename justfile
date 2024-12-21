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

setup-diplomacy-web:
    #!/usr/bin/env sh
    # Install nvm
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    
    # Source nvm in current shell
    . "$HOME/.nvm/nvm.sh"
    
    # Install and use Node.js 16 instead of latest
    nvm install 16
    nvm use 16
    
    # Clone repo if needed
    if [ ! -d "diplomacy" ]; then
        git clone https://github.com/diplomacy/diplomacy.git
    fi
    
    # Create package.json if it doesn't exist
    cd diplomacy/diplomacy/web
    if [ ! -f "package.json" ]; then
        echo '{"name": "diplomacy-web","version": "1.0.0"}' > package.json
    fi
    
    npm install .
    npm install . --only=dev

run-diplomacy-web-react:
    #!/usr/bin/env sh
    cd diplomacy/diplomacy/web
    if [ ! -f "package.json" ]; then
        echo "Error: package.json not found. Please run 'just setup-diplomacy-web' first."
        exit 1
    fi
    export NODE_OPTIONS=--openssl-legacy-provider
    npm start

run-diplomacy-web-server:
    cd diplomacy
    python -m diplomacy.server.run

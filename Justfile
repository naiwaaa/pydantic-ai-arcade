set dotenv-load := true

export COVERAGE_CORE := "sysmon"
export PYTHONDONTWRITEBYTECODE := "1"

# ----
# Help
# ----

# List all available commands
default:
    @just --list --unsorted

# ------------
# Dependencies
# ------------

# Install dependencies and pre-commit hooks for local development
[group("Dependencies")]
install:
    uv sync --all-packages
    prek install --install-hooks

# Upgrade dependencies and hooks
[group("Dependencies")]
upgrade:
    uv lock --upgrade
    prek auto-update

# --------------------
# Code Quality & Tests
# --------------------

# Auto-fix and format code
[group("Code Quality & Tests")]
format:
    uv run ruff check --fix .
    uv run ruff format .

# Lint and check formatting
[group("Code Quality & Tests")]
lint:
    uv run ruff check .
    uv run ruff format --check .

# Perform type checking
[group("Code Quality & Tests")]
typecheck:
    uv run mypy .

# Run unit tests
[group("Code Quality & Tests")]
test:
    uv run pytest

# Run lint, typecheck, and tests
[group("Code Quality & Tests")]
all: lint typecheck test

# --------------
# Advanced Tests
# --------------

# Run slow tests
[group("Advanced tests")]
test-slow:
    uv run pytest -m "slow"

# Run benchmarks
[group("Advanced tests")]
test-benchmark:
    uv run pytest --benchmark-only

# --------
# Clean Up
# --------

# Remove caches and build artifacts
[group("Clean Up")]
clean:
    rm -rf dist
    rm -rf .cache
    rm -rf .hypothesis
    rm -rf `find . -name __pycache__`
    rm -f `find . -type f -name '*.py[co]'`

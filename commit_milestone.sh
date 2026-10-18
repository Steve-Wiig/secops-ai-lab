#!/usr/bin/env bash
set -e

echo "========================================================"
echo " Securing State: Milestone v1.0 (Core Complete)"
echo "========================================================"

# 1. Create a strict .gitignore to prevent clutter
cat << 'GITIGNORE' > .gitignore
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
env/
venv/
.env

# Backups & Logs (CRITICAL: Do not commit .bak files or runtime logs)
*.bak
*.bak.*
*.log
overnight/continuous_supervisor.log

# IDE & OS
.vscode/
.idea/
.DS_Store

# Aider artifacts
.aider.tags.cache.v3/
.aider.chat.history.md

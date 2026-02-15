#!/bin/bash
# Entrypoint script for dotfiles development environment

# Check if mise tools are installed
if ! mise list 2>/dev/null | grep -q .; then
    echo "🚀 First run detected! Installing mise tools..."
    echo "This may take a few minutes..."
    mise install 2>&1 | grep -E "(install|✓|ERROR|WARN)" || true
    echo "✅ Tools installed!"
    echo ""
fi

# Start zsh
exec /bin/zsh "$@"

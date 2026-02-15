#!/bin/bash
# Entrypoint script for dotfiles development environment

# Check if mise tools are installed
if ! mise list 2>/dev/null | grep -q .; then
    echo "🚀 First run detected! Installing mise tools..."
    echo "This may take a few minutes..."
    echo ""
    
    # Install and show output
    if mise install 2>&1; then
        echo ""
        echo "✅ Tools installed successfully!"
    else
        echo ""
        echo "⚠️  Some tools failed to install. This may be due to GitHub API rate limits."
        echo "You can set GITHUB_TOKEN environment variable to increase rate limits."
        echo "Or run 'mise install' manually inside the container."
    fi
    echo ""
fi

# Start zsh
exec /bin/zsh "$@"

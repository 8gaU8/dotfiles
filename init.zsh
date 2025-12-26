#! /bin/zsh

# Activate mise 
eval "$(${HOME}/.local/bin/mise activate zsh)"

# Setup cache directories for completions and activations
export COMPLETION_CACHE_DIR="${HOME}/.cache/zsh_completions"
export ACTIVATE_CACHE_DIR="${HOME}/.cache/zsh_activations"
export MAX_CACHE_AGE_SECONDS=86400  # 1 day

# Set ZSH_CUSTOM (for compatibility. should be fixed later)
export ZSH_CUSTOM="$(dirname $0)/custom"


fpath+="${COMPLETION_CACHE_DIR}"

# Setup Sheldon
export SHELDON_CONFIG_DIR="$(dirname $0)/sheldon"
eval "$(sheldon source)"

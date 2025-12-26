
export COMPLETION_CACHE_DIR="${HOME}/.cache/zsh_completions"



fpath+="${COMPLETION_CACHE_DIR}"

# autoload -Uz compinit && compinit

export SHELDON_CONFIG_DIR="$(dirname $1)/sheldon"
eval "$(sheldon source)"

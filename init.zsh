
export COMPLETION_CACHE_DIR="${HOME}/.cache/zsh_completions"

# Path to Customization
export ZSH_CUSTOM="$HOME/zsh-dotfiles/custom"

export SHELDON_CONFIG_DIR="$(dirname $1)/sheldon"

# import customs
for config_file in $ZSH_CUSTOM/*.zsh; do
  [ -f "$config_file" ] && source "$config_file"
done

# source $ZSH_CUSTOM/themes/ultima.zsh-theme


fpath=("${COMPLETION_CACHE_DIR}" $fpath)

# autoload -Uz compinit && compinit

eval "$(sheldon source)"

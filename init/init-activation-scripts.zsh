#! /usr/bin/env zsh

DOTFILES_DIR="${HOME}/dotfiles"
activation_cache_file="${DOTFILES_DIR}/custom/activation-cache.gen.zsh"

function _evalcache() {
  local name="$(basename "$1")"
  eval "$@" >>| "$activation_cache_file"
}


if [ -f "$activation_cache_file" ]; then
  rm  "$activation_cache_file"
fi

_evalcache starship init zsh
_evalcache /opt/homebrew/bin/brew shellenv
_evalcache try init ~/src/tries
_evalcache fzf --zsh
_evalcache zoxide init zsh --cmd cd

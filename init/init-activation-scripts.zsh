#! /usr/bin/env zsh

DOTFILES_DIR="${DOTFILES_DIR:-${HOME}/dotfiles}"
activation_cache_file="${DOTFILES_DIR}/custom/activation-cache.gen.zsh"

function _evalcache() {
  local name="$(basename "$1")"
  if ! command -v "$name" > /dev/null 2>&1; then
    echo "# ${name} not found: skip cache generation" >>| "$activation_cache_file"
    return
  fi
  eval "$@" >>| "$activation_cache_file"
}


: >| "$activation_cache_file"

_evalcache starship init zsh
_evalcache brew shellenv
_evalcache try init ~/src/tries
_evalcache fzf --zsh
_evalcache zoxide init zsh --cmd cd

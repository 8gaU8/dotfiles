#! /usr/bin/env zsh

_evalcache /opt/homebrew/bin/brew shellenv
_evalcache ruby ~/.local/try.rb init ~/src/tries
_evalcache fzf --zsh
_evalcache zoxide init zsh --cmd cd

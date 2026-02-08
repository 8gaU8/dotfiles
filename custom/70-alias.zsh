#! /usr/bin/env zsh

alias cat="bat"
alias o="/usr/bin/open"
alias c="code ."
alias pbc="/usr/bin/pbcopy"
alias pbp="/usr/bin/pbpaste"
alias ls="eza"
alias ll="eza --icons -al --group-directories-first"
alias la="eza -aG"
alias l="eza"
alias grep="grep --color=auto"

alias ...='cd ./../..'
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"
alias http-serve='python3 -m http.server'
alias vdiff="code --new-window --diff --wait"

alias u="update_zsh_custom"

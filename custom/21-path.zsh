#! /usr/bin/env zsh

## Add common user bin directories
add_to_path_if_exists "${HOME}/.local/bin"
## LM Studio
add_to_path_if_exists "${HOME}/.lmstudio/bin"
## Antigravity
add_to_path_if_exists "${HOME}/.antigravity/antigravity/bin"
## Rust
add_to_path_if_exists "${HOME}/.cargo/bin"
## ghcup
add_to_path_if_exists "${HOME}/.ghcup/bin"
## Cabal
add_to_path_if_exists "${HOME}/.cabal/bin"
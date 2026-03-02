#! /usr/bin/env zsh

## Add common user bin directories
add_to_path_if_exists "${HOME}/.local/bin"
## Antigravity
add_to_path_if_exists "${HOME}/.antigravity/antigravity/bin"
## Rust
add_to_path_if_exists "${HOME}/.cargo/bin"

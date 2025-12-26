#* === initialize ===
cached_completion_init
cached_activation_init

#* === update path ===

## Homebrew
add_to_path_if_exists "/opt/homebrew/bin"
add_to_path_if_exists "/opt/homebrew/sbin"
## Add common user bin directories
add_to_path_if_exists "${HOME}/.local/bin"
## LM Studio
add_to_path_if_exists "${HOME}/.lmstudio/bin"
## Antigravity
add_to_path_if_exists "${HOME}/.antigravity/antigravity/bin"
## Rust
add_to_path_if_exists "${HOME}/.cargo/bin"




#* === Activations ===
cached_activation _brew /opt/homebrew/bin/brew shellenv
cached_activation _try ruby ~/.local/try.rb init ~/src/tries
cached_activation _fzf fzf --zsh

## ghcup
source_if_exists ${HOME}/.ghcup/env

## rust
source_if_exists ${HOME}/.cargo/env

#* === Completions ===

cached_completion _tailscale tailscale completion zsh
cached_completion _uv uv generate-shell-completion zsh
cached_completion _uvx uvx --generate-shell-completion=zsh
cached_completion _gh gh completion -s zsh
cached_completion _mise mise completion zsh
cached_completion _pnpm pnpm completion zsh
cached_completion _sheldon sheldon completions --shell zsh
cached_completion _rustup rustup completions zsh rustup
cached_completion _cargo rustup completions zsh cargo

#* === Environment Variables ===

# pip: Avoid pip installation without venv
export PIP_REQUIRE_VIRTUALENV=1

# man: use bat as manpager
if command -v bat &> /dev/null; then
  export MANPAGER="sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'"
else
  warn "bat command not found, skipping manpager setup."
fi

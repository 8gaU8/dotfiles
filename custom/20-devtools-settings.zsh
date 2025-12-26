#* === initialize ===
cached_completion_init

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

## Homebrew
if command -v /opt/homebrew/bin/brew &> /dev/null; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  warn "brew command not found, skipping brew setup."
fi

## Mise
if command -v "${HOME}/.local/bin/mise" &> /dev/null; then
  eval "$(${HOME}/.local/bin/mise activate zsh)"
else
  warn "mise command not found, skipping mise setup."
fi

## try
if command -v ruby &> /dev/null; then
  eval "$(ruby ~/.local/try.rb init ~/src/tries)"
else
  warn "ruby command not found, skipping tobi/try setup."
fi

## ghcup
source_if_exists ${HOME}/.ghcup/env

## rust
source_if_exists ${HOME}/.cargo/env

#* === Completions ===

cached_completion tailscale completion zsh
cached_completion uv generate-shell-completion zsh
cached_completion gh completion -s zsh
cached_completion mise completion zsh
cached_completion pnpm completion zsh

#* === Environment Variables ===

# pip: Avoid pip installation without venv
export PIP_REQUIRE_VIRTUALENV=1

# man: use bat as manpager
if command -v bat &> /dev/null; then
  export MANPAGER="sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'"
else
  warn "bat command not found, skipping manpager setup."
fi

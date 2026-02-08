#! /usr/bin/env zsh

# Activate mise
if [ -z "${VSCODE_INJECTION}" ]; then
	eval "$(${HOME}/.local/bin/mise activate zsh)"
else
	eval "$(${HOME}/.local/bin/mise activate zsh --shims)"
fi

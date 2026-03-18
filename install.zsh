#! /usr/bin/env zsh

set -euo pipefail

REPO_URL="https://github.com/8gau8/dotfiles"
INSTALL_PATH="${HOME}/dotfiles"
SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" >/dev/null 2>&1 && pwd)"

if [[ -f "${SCRIPT_DIR}/mise.toml" && -d "${SCRIPT_DIR}/init" ]]; then
	if [[ "${SCRIPT_DIR}" == "${INSTALL_PATH}" ]]; then
		INSTALL_PATH="${SCRIPT_DIR}"
	elif [[ ! -d "${INSTALL_PATH}/.git" ]]; then
		git clone "${REPO_URL}" "${INSTALL_PATH}"
	fi
elif [[ ! -d "${INSTALL_PATH}/.git" ]]; then
	git clone "${REPO_URL}" "${INSTALL_PATH}"
fi

if ! command -v mise >/dev/null 2>&1; then
	echo "Mise not found. Installing..."
	tmp_mise_installer="$(mktemp)"
	curl -fsSL https://mise.run -o "${tmp_mise_installer}"
	sh "${tmp_mise_installer}"
	rm -f "${tmp_mise_installer}"
	export PATH="${HOME}/.local/bin:${PATH}"
else
	echo "Mise is already installed."
fi

mkdir -p "${HOME}/.config/mise" "${HOME}/.config/ghostty"
if [[ -f "${HOME}/.config/mise/config.toml" && ! -f "${HOME}/.config/mise/config.toml.bak" ]]; then
	cp "${HOME}/.config/mise/config.toml" "${HOME}/.config/mise/config.toml.bak"
fi
if [[ -f "${HOME}/.config/ghostty/config" && ! -f "${HOME}/.config/ghostty/config.bak" ]]; then
	cp "${HOME}/.config/ghostty/config" "${HOME}/.config/ghostty/config.bak"
fi
echo "Updating ${HOME}/.config/mise/config.toml from dotfiles"
cp "${INSTALL_PATH}/config/mise.global.toml" "${HOME}/.config/mise/config.toml"
echo "Updating ${HOME}/.config/ghostty/config from dotfiles"
cp "${INSTALL_PATH}/config/ghostty/config" "${HOME}/.config/ghostty/config"
export DOTFILES_DIR="${INSTALL_PATH}"
if [[ -f "${HOME}/.zshrc" && ! -f "${HOME}/.zshrc.bak" ]]; then
	cp "${HOME}/.zshrc" "${HOME}/.zshrc.bak"
fi

cd "${INSTALL_PATH}" && \
	mise install && \
	cp zshrc "${HOME}/.zshrc" && \
	zsh ./init/load-activation.zsh && \
	zsh ./init/init-activation-scripts.zsh && \
	cd - >/dev/null

#! /usr/bin/env zsh

set -euo pipefail

REPO_URL="https://github.com/8gau8/dotfiles"
INSTALL_PATH="${HOME}/dotfiles"
SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" >/dev/null 2>&1 && pwd)"

function install_mise_from_github_release() {
	local os arch platform latest_tag asset url tmp_dir

	case "$(uname -s)" in
	Linux) platform="linux" ;;
	Darwin) platform="macos" ;;
	*) return 1 ;;
	esac

	case "$(uname -m)" in
	x86_64 | amd64) arch="x64" ;;
	arm64 | aarch64) arch="arm64" ;;
	*) return 1 ;;
	esac

	local latest_release_headers
	latest_release_headers="$(curl -I -fsSL https://github.com/jdx/mise/releases/latest)" || { echo "Failed to reach GitHub releases for mise" >&2; return 1; }
	latest_tag="$(echo "${latest_release_headers}" | sed -n 's/^location: .*\/tag\/\(v[^[:space:]]*\).*/\1/ip' | tail -n 1 | tr -d '\r')"
	if [[ -z "${latest_tag}" ]]; then
		echo "Failed to resolve latest mise release tag from GitHub" >&2
		return 1
	fi

	asset="mise-${latest_tag}-${platform}-${arch}.tar.gz"
	url="https://github.com/jdx/mise/releases/download/${latest_tag}/${asset}"
	tmp_dir="$(mktemp -d)"
	curl -fsSL "${url}" -o "${tmp_dir}/mise.tar.gz" || { echo "Failed to download ${asset} from ${url}" >&2; rm -rf "${tmp_dir}"; return 1; }
	tar -xzf "${tmp_dir}/mise.tar.gz" -C "${tmp_dir}" || { echo "Failed to extract ${asset}" >&2; rm -rf "${tmp_dir}"; return 1; }
	mkdir -p "${HOME}/.local/bin"
	install -m 0755 "${tmp_dir}/mise/bin/mise" "${HOME}/.local/bin/mise" || { echo "Failed to install mise binary" >&2; rm -rf "${tmp_dir}"; return 1; }
	rm -rf "${tmp_dir}"
}

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
	if curl -fsSL https://mise.run -o "${tmp_mise_installer}"; then
		sh "${tmp_mise_installer}"
	else
		echo "mise.run is unreachable. Falling back to GitHub release installer..."
		install_mise_from_github_release
	fi
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

cd "${INSTALL_PATH}"
mise trust
if [[ "${DOTFILES_SKIP_MISE_INSTALL:-0}" != "1" ]]; then
	mise install
else
	echo "DOTFILES_SKIP_MISE_INSTALL=1: skipping mise install"
fi
cp zshrc "${HOME}/.zshrc"
DOTFILES_DIR="${INSTALL_PATH}" zsh ./init/load-activation.zsh
DOTFILES_DIR="${INSTALL_PATH}" zsh ./init/init-activation-scripts.zsh
cd - >/dev/null

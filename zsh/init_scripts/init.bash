#! /bin/bash

set -o errexit
set -o nounset
set -o pipefail

echo "Current directory: $(pwd)"
_init_scripts_dir="$(dirname "${BASH_SOURCE[0]}")"

_zshdir="$(dirname "${_init_scripts_dir}")"
cd "${_zshdir}"

zshdir="$(pwd)"
custom_dir="${zshdir}/custom"

function activation() {

    eval "$("${HOME}"/.local/bin/mise activate bash --shims)"

    local activation_cache_file="${custom_dir}/activation-cache.gen.zsh"
    :> "$activation_cache_file"

    function _evalcache() {
        echo "Evaluating: $*"
        # exit if the command is not available
        if ! command -v "$1" &> /dev/null; then
            echo "Command $1 not found, skipping."
            return
        fi
        "$@" >> "$activation_cache_file"
    }

    # shellcheck disable=SC1091
    source "${zshdir}/activations-list.txt"
}


function plugins() {
    local plugin_bundle_file="${custom_dir}/bundled-plugins.gen.zsh"
    local plugins_download_dir="${zshdir}/plugins"
    :> "$plugin_bundle_file"


    function clone(){
        local plugin_name="${1}"
        local plugin_path="${2}"
        if [[ ! -d "$plugin_path" ]]; then
            # GIT_TERMINAL_PROMPT=0 でユーザー名/パスワードの入力プロンプトを無効化し、即座に失敗させます
            GIT_TERMINAL_PROMPT=0 git clone --depth=1 "https://github.com/${plugin_name}.git" "$plugin_path" 2>/dev/null || true
        else
            # If the directory already exists, we can choose to pull the latest changes or skip
            echo "Plugin ${plugin_name} already exists at ${plugin_path}, skipping clone."
            # Uncomment the following lines to pull the latest changes instead of skipping
            # echo "Updating plugin ${plugin_name} at ${plugin_path}..."
            # GIT_TERMINAL_PROMPT=0 git -C "$plugin_path" pull --depth=1 2>/dev/null || true
        fi
    }

    function source_plugin(){
        local plugin_name="$1"
        local script_to_use="$2"
        local plugin_path="${plugins_download_dir}/${plugin_name}"
        clone "${plugin_name}" "${plugin_path}"
        
        # プラグインのスクリプトが存在しない場合はバンドル処理をスキップ
        if [[ ! -f "${plugin_path}/${script_to_use}" ]]; then
            echo "⚠️  Skipping source: ${plugin_path}/${script_to_use} not found."
            return
        fi

        {
            echo "# --- Source: ${plugin_name} (${script_to_use}) ---"
            echo "{ # --- try block start ---"
            echo "source \"${plugin_path}/${script_to_use}\""
            echo "} 2>/dev/null || true # --- catch block ---"
            echo -e "\n"
        } >> "$plugin_bundle_file"
    }

    function bundle_plugin(){
        local plugin_name="$1"
        local script_to_use="$2"
        local plugin_path="${plugins_download_dir}/${plugin_name}"
        clone "${plugin_name}" "${plugin_path}"
        
        # プラグインのスクリプトが存在しない場合はバンドル処理をスキップ (catのエラー防止)
        if [[ ! -f "${plugin_path}/${script_to_use}" ]]; then
            echo "⚠️  Skipping bundle: ${plugin_path}/${script_to_use} not found."
            return
        fi

        {
            echo "# --- Source: ${plugin_name} (${script_to_use}) ---"
            echo "{ # --- try block start ---"
            cat "${plugin_path}/${script_to_use}"
            echo "} 2>/dev/null || true # --- catch block ---"
            echo -e "\n"
        } >> "$plugin_bundle_file"
    }

    # shellcheck disable=SC1091
    source "${zshdir}/plugins-list.txt"

}

function bundle() {
    local bundle_file="${zshdir}/custom.bundle.zsh"

    # Generate bundled file when it doesn't exist

    : >"${bundle_file}"

    for f in "${custom_dir}"/*.gen.zsh; do
        # globでファイルが見つからなかった場合のスキップ処理
        [[ -e "$f" ]] || continue
        
        echo "  Appending $f..."
        {
            echo "# --- Source: ${f} ---"
            echo "{ # --- try block start ---"
            cat "$f"
            echo "} 2>/dev/null || true # --- catch block ---"
            echo
        } >> "${bundle_file}"
    done

    # Concatenate scripts sequentially
    for f in "${custom_dir}"/[0-9][0-9]-*.zsh; do
        [[ -e "$f" ]] || continue
        
        echo "  Appending $f..."
        {
            echo "# --- Source: ${f} ---"
            echo "{ # --- try block start ---"
            cat "$f"
            echo "} 2>/dev/null || true # --- catch block ---"
            echo
        } >> "${bundle_file}"
    done

    echo "✅ Bundle created: ${bundle_file}"
}


# main
activation
plugins
bundle
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
        which "$1" 
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
            git clone --depth=1 "https://github.com/${plugin_name}.git" "$plugin_path"
        else
            # If the directory already exists, we can choose to pull the latest changes or skip
            echo "Plugin ${plugin_name} already exists at ${plugin_path}, skipping clone."
            # Uncomment the following lines to pull the latest changes instead of skipping
            # echo "Updating plugin ${plugin_name} at ${plugin_path}..."
            # git -C "$plugin_path" pull --depth=1
        fi
    }

    function source_plugin(){
        local plugin_name="$1"
        local script_to_use="$2"
        local plugin_path="${plugins_download_dir}/${plugin_name}"
        clone "${plugin_name}" "${plugin_path}"
        {
            echo "# --- Source: ${plugin_name} (${script_to_use}) ---" 
            echo "source ${plugin_path}/${script_to_use}" 
            echo -e "\n" 
        } >> "$plugin_bundle_file"
    }

    function bundle_plugin(){
        local plugin_name="$1"
        local script_to_use="$2"
        local plugin_path="${plugins_download_dir}/${plugin_name}"
        clone "${plugin_name}" "${plugin_path}"
        {
            echo "# --- Source: ${plugin_name} (${script_to_use}) ---" 
            cat "${plugin_path}/${script_to_use}" 
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
        echo "  Appending $f..."
        {
            echo "# --- Source: ${f} ---" 
            cat "$f"
            echo -e 
        } >> "${bundle_file}"
    done

    # Concatinate scripts sequencially
    for f in "${custom_dir}"/[0-9][0-9]-*.zsh; do
        echo "  Appending $f..."
        {
            echo "# --- Source: ${f} ---"
            cat "$f"
            echo -e
        } >> "${bundle_file}"
    done

    echo "✅ Bundle created: ${bundle_file}"
}


# main
activation
plugins
bundle
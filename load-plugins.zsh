#! /usr/bin/env zsh

DOTFILES="${HOME}/dotfiles"

plugin_file="${DOTFILES}/custom/00-source-plugins.gen.zsh"
plugin_bundle_file="${DOTFILES}/custom/01-bundled-plugins.gen.zsh"
plugins_download_dir="${DOTFILES}/plugins"

function clone(){
    local plugin_name="${1}"
    local plugin_path="${2}"
    if [[ ! -d "$plugin_path" ]]; then
        git clone --depth=1 "https://github.com/${plugin_name}.git" "$plugin_path"
    fi
}

function source_plugin(){
    local plugin_name="$1"
    local script_to_use="$2"
    local plugin_path="${plugins_download_dir}/${plugin_name}"
    clone "${plugin_name}" "${plugin_path}"
    echo "source ${plugin_path}/${script_to_use}" >> "$plugin_file"
}

function bundle_plugin(){
    local plugin_name="$1"
    local script_to_use="$2"
    local plugin_path="${plugins_download_dir}/${plugin_name}"
    clone "${plugin_name}" "${plugin_path}"
    cat "${plugin_path}/${script_to_use}" >> "$plugin_bundle_file"
    echo -e "\n" >> "$plugin_bundle_file"
}

rm -f "$plugin_file" "$plugin_bundle_file"

source_plugin "zdharma-continuum/fast-syntax-highlighting" "fast-syntax-highlighting.plugin.zsh"

bundle_plugin "mroth/evalcache" "evalcache.plugin.zsh"
bundle_plugin "zsh-users/zsh-autosuggestions" "zsh-autosuggestions.zsh"
bundle_plugin "rcmdnk/shell-logger" "etc/shell-logger"
bundle_plugin "ohmyzsh/ohmyzsh" "plugins/brew/brew.plugin.zsh"
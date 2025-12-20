# (1) 即時実行のための無名関数を定義し、実行します。
# これにより、このファイルの処理が完了すると、
# この関数内のローカル変数とともに、関数add_to_path_if_existsの定義も消滅します。
() {
    source "${HOME}/.local/usr/shell-logger/etc/shell-logger"

    # example
    # $ add_to_path_if_exists "/usr/local/bin"

    # zshの配列属性を活用し、重複を防ぎます
    typeset -U path

    # ディレクトリが存在する場合のみPATHに追加し、存在しない場合は警告を出す関数
    add_to_path_if_exists() {
        local dir="$1"
        
        if [[ -z "$dir" ]]; then
            error "add_to_path_if_exists: Directory argument is required."
            return 1
        fi

        if [[ -d "$dir" ]]; then
            # PATHの先頭に追加
            path=("$dir" $path)
            export PATH
        else
            warn "Directory not found. Skipping addition to PATH: $dir"
            return 1
        fi
    }
    
    source_if_exists() {
        local file="$1"
        
        if [[ -z "$file" ]]; then
            error "Directory argument is required."
            return 1
        fi

        if [[ -d "$file" ]]; then
            # PATHの先頭に追加
            source "$file"
        else
            warn "File not found. Skipping sourcing it: $file" 
            return 1
        fi
    }

    cached_completion(){
        # usage: cached_completion <command> <completion generation command...>
        # example: cached_completion uv generate-shell-completion zsh
        local base_cmd="${1}"
        local commands="${*}"
        local cache_dir="${HOME}/.cache/zsh_completion"
        [[ ! -d "${cache_dir}" ]] && mkdir -p "${cache_dir}"
        local cache_file="${cache_dir}/${base_cmd}.zsh"

        if [[ -z "${base_cmd}" ]]; then
            error "cached_completion: Command argument is required."
            return 1
        fi

        # check command existence
        if ! command -v ${base_cmd} &> /dev/null; then
          warn "${base_cmd} command not found, skipping ${base_cmd} autocompletion setup."
          return 1
        fi

        if [[ -f "${cache_file}" ]]; then
            info "Using cached completion for command: ${base_cmd}"
            source "${cache_file}"
        else
            # キャッシュが存在しないか、古い場合は新たに生成
            info "Generating completion cache for command: ${base_cmd}"
            eval "${commands}" >| "${cache_file}"
            source "${cache_file}"
        fi

    }

}

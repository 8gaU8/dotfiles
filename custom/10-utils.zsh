# (1) 即時実行のための無名関数を定義し、実行します。
# これにより、このファイルの処理が完了すると、
# この関数内のローカル変数とともに、関数add_to_path_if_existsの定義も消滅します。
() {
    # example
    # $ add_to_path_if_exists "/usr/local/bin"
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

        if [[ -f "$file" ]]; then
            source "$file"
        else
            warn "File not found. Skipping sourcing it: $file" 
            return 1
        fi
    }

    is_file_recent() {
        local file="$1"
        local max_age_seconds="$2"

        if [[ ! -f "$file" ]]; then
            return 1
        fi

        local file_mod_time=$(stat -f %m "$file")
        local current_time=$(date +%s)
        local age=$((current_time - file_mod_time))

        if (( age <= max_age_seconds )); then
            return 0
        else
            return 1
        fi
    }

    cached_completion_init(){
        local cache_dir="${COMPLETION_CACHE_DIR}"
        [[ ! -d "${cache_dir}" ]] && mkdir -p "${cache_dir}"
    }

    cached_completion(){
        # usage: cached_completion <command> <completion generation command...>
        # example: cached_completion uv generate-shell-completion zsh
        local filename="${1}"
        local base_cmd="${2}"
        local commands="(${@[2,-1]})"
        local cache_file="${COMPLETION_CACHE_DIR}/${filename}"

        # check command existence
        if ! command -v ${base_cmd} &> /dev/null; then
          warn "${base_cmd} command not found, skipping ${base_cmd} autocompletion setup."
          return 1
        fi

        if is_file_recent "${cache_file}" "${MAX_CACHE_AGE_SECONDS}"; then
            info "Using cached completion for command: ${base_cmd}"
        else
            # キャッシュが存在しないか、古い場合は新たに生成
            info "Generating completion cache for command: ${base_cmd}"
            eval "${commands}" >| "${cache_file}"
        fi

    }

    cached_activation_init(){
        local cache_dir="${ACTIVATE_CACHE_DIR:-${HOME}/.cache/zsh_activate}"
        [[ ! -d "${cache_dir}" ]] && mkdir -p "${cache_dir}"
    }

    cached_activation(){
        # usage: cached_completion <command> <completion generation command...>
        # example: cached_completion uv generate-shell-completion zsh
        local base_cmd="$(basename ${1})"
        local commands="${*}"
        local cache_file="${ACTIVATE_CACHE_DIR:-${HOME}/.cache/zsh_activate}/${base_cmd}"

        # check command existence
        if ! command -v ${base_cmd} &> /dev/null; then
          warn "${base_cmd} command not found, skipping ${base_cmd} activation setup."
          return 1
        fi

        # Check if cache file exists and is recent (within 1 day)
        if is_file_recent "${cache_file}" "${MAX_CACHE_AGE_SECONDS}"; then
            info "Using cached activation for command: ${base_cmd}"
        else
            # キャッシュが存在しないか、古い場合は新たに生成
            info "Generating activation cache for command: ${base_cmd}"
            eval "${commands}" >| "${cache_file}"
        fi

        info "Sourcing activation cache for command: ${base_cmd}"
        source "${cache_file}"

    }



}

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

    # Generic cache initialization function
    _cache_init(){
        local cache_dir="${1}"
        [[ ! -d "${cache_dir}" ]] && mkdir -p "${cache_dir}"
    }

    cached_completion_init(){
        _cache_init "${COMPLETION_CACHE_DIR}"
    }

    cached_activation_init(){
        _cache_init "${ACTIVATE_CACHE_DIR:-${HOME}/.cache/zsh_activate}"
    }

    # Generic function to handle cached command evaluation
    # Returns 0 if successful, 1 if command not found
    _cached_eval(){
        local cache_file="${1}"
        local base_cmd="${2}"
        local commands="${3}"
        local cache_type="${4}"  # "completion" or "activation"

        # check command existence
        if ! command -v ${base_cmd} &> /dev/null; then
          warn "${base_cmd} command not found, skipping ${base_cmd} ${cache_type} setup."
          return 1
        fi

        if is_file_recent "${cache_file}" "${MAX_CACHE_AGE_SECONDS}"; then
            info "Using cached ${cache_type} for command: ${base_cmd}"
        else
            # キャッシュが存在しないか、古い場合は新たに生成
            info "Generating ${cache_type} cache for command: ${base_cmd}"
            eval "${commands}" >| "${cache_file}"
        fi

        return 0
    }

    cached_completion(){
        # usage: cached_completion <filename> <command> <completion generation command...>
        # example: cached_completion _uv uv generate-shell-completion zsh
        local filename="${1}"
        shift
        local base_cmd="${1}"
        shift
        local commands="$*"
        local cache_file="${COMPLETION_CACHE_DIR}/${filename}"

        _cached_eval "${cache_file}" "${base_cmd}" "${commands}" "completion"
    }

    cached_activation(){
        # usage: cached_activation <command> <activation generation command...>
        # example: cached_activation fzf --zsh
        local base_cmd="$(basename ${1})"
        local commands="${*}"
        local cache_file="${ACTIVATE_CACHE_DIR:-${HOME}/.cache/zsh_activate}/${base_cmd}"

        if _cached_eval "${cache_file}" "${base_cmd}" "${commands}" "activation"; then
            info "Sourcing activation cache for command: ${base_cmd}"
            source "${cache_file}"
        fi
    }



}

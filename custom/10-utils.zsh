#! /usr/bin/env zsh

update_zsh_custom() {
    # check this repository if it's the latest version
	(
		cd "$DOTFILES_DIR"
		echo "Checking for updates in ${DOTFILES_DIR}..."
		if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
			# Not a git repository, nothing to do.
			exit
		fi

		# # Fetch remote updates quietly
		git fetch --quiet

		# # Check if the local branch is behind the remote
		if git status -uno | grep -q 'Your branch is behind'; then
			echo "\033[0;33m[oh-my-zsh custom] Your custom scripts are not up to date.\033[0m"
			read -q "REPLY?[oh-my-zsh custom] Do you want to pull the latest changes? (y/N) "
			echo
			if [[ "$REPLY" =~ ^[Yy]$ ]]; then
				echo "\033[0;33m[oh-my-zsh custom] Pulling latest changes...\033[0m"
				git pull
			else
				echo "\033[0;33m[oh-my-zsh custom] Skipped. Please run 'git pull' in ~/.oh-my-zsh/custom later.\033[0m"
			fi
		fi
	)
}

add_to_path_if_exists() {
    # example
    # $ add_to_path_if_exists "/usr/local/bin"
    # ディレクトリが存在する場合のみPATHに追加し、存在しない場合は警告を出す関数
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

on_demand_completion() {
  local cmd_name=$1
  local completion_command=$2
  local function_name="_${cmd_name}"
  local comp_cmd_name="${completion_command%% *}"

  eval "function $function_name() {
    if ! command -v "$comp_cmd_name" &> /dev/null; then
      return
    fi
    unfunction '$function_name'
    eval \"\$(eval $completion_command)\"
    \$_comps[$cmd_name]
  }"

  compdef $function_name $cmd_name
}


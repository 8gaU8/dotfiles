# check this repository if it's the latest version
update_zsh_custom() {
  (
    cd "$ZSH_CUSTOM"
    echo "Checking for updates in $ZSH_CUSTOM..."
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


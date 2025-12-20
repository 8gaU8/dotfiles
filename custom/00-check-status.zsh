# check if shell-logger is available
(
  shell_logger_path="$HOME/.local/usr/shell-logger"
  if [[ -z $shell_logger_path || ! -d $shell_logger_path ]]; then
    echo "\033[0;31m[shell-logger] shell-logger is not installed in $shell_logger_path.\033[0m"
    echo "\033[0;31m[shell-logger] Please install shell-logger to enable logging features.\033[0m"

    read -q "REPLY?[oh-my-zsh custom] Do you want to clone the latest shell-logger? (y/N) "
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
      echo "\033[0;33m[oh-my-zsh custom] Cloning the latest shell-logger...\033[0m"
      git clone https://github.com/rcmdnk/shell-logger.git "$shell_logger_path"
    else
      echo "\033[0;33m[oh-my-zsh custom] Skipped. Please clone shell logger at ${shell_logger_path} later.\033[0m"
    fi
  fi
)

# check this repository if it's the latest version
(
  cd "$ZSH_CUSTOM"
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

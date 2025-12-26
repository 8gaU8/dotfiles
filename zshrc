# custom hook to auto-compile zsh scripts
# ref: https://zenn.dev/fuzmare/articles/zsh-source-zcompile-all

function source {
  ensure_zcompiled $1
  builtin source $1
}

function ensure_zcompiled {
  local compiled="$1.zwc"
  if [[ ! -r "$compiled" || "$1" -nt "$compiled" ]]; then
    echo "Compiling $1"
    zcompile $1
  fi
}

ensure_zcompiled "$(dirname $0)/init.zsh"
source "$(dirname $0)/init.zsh"


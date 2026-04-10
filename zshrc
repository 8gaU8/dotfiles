#! /usr/bin/env zsh

# ========= custom hook to auto-compile zsh scripts ============
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

# compile zshrc itself
ensure_zcompiled "${HOME}/.zshrc"

# Custom Config Locations
export DOTFILES_DIR="${HOME}/dotfiles"

# ====== Bundle custom/*.zsh scripts =========
# Configure Bundle Path
bundle_file="$DOTFILES_DIR/custom.bundle.zsh"

autoload -Uz compinit && compinit

# 4. Load the bundled file
cd "$DOTFILES_DIR" && \
    source "$bundle_file" && \
    cd - > /dev/null


unfunction source

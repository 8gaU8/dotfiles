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
export BASE_CONFIG_DIR="${DOTFILES_DIR}/config"

# ====== Bundle custom/*.zsh scripts =========
# Configure Bundle Path
BUNDLE_FILE="$DOTFILES_DIR/custom.bundle.zsh"
CUSTOM_DIR="$DOTFILES_DIR/custom"

# Generate bundled file when it doesn't exist
if [[ ! -f "$BUNDLE_FILE" ]]; then
	echo "⚡️ Zsh bundle not found. Building for the first time..."

	# Start bundle
	: >"$BUNDLE_FILE"

	for f in "$CUSTOM_DIR"/*.gen.zsh; do
		echo "  Appending $f..."
		echo "# --- Source: ${f:t} ---" >>"$BUNDLE_FILE"
		cat "$f" >>"$BUNDLE_FILE"
		echo -e "\n" >>"$BUNDLE_FILE"
	done

	# Concatinate scripts sequencially
	for f in "$CUSTOM_DIR"/[0-9][0-9]-*.zsh; do
		echo "  Appending $f..."
		echo "# --- Source: ${f:t} ---" >>"$BUNDLE_FILE"
		cat "$f" >>"$BUNDLE_FILE"
		echo -e "\n" >>"$BUNDLE_FILE"
	done

	echo "✅ Bundle created: $BUNDLE_FILE"
fi

autoload -Uz compinit && compinit

# 4. Load the bundled file
cd "$DOTFILES_DIR" && \
    source "$BUNDLE_FILE" && \
    cd - > /dev/null


unfunction source

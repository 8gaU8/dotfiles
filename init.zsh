#! /usr/bin/env zsh

# Setup cache directories for completions and activations
export MAX_CACHE_AGE_SECONDS=86400 # 1 day


# Custom Config Locations
export DOTFILES_DIR="$(dirname $0)"
export BASE_CONFIG_DIR="$(dirname $0)/config"

export MISE_GLOBAL_CONFIG_FILE="${BASE_CONFIG_DIR}/mise.global.toml"
export STARSHIP_CONFIG="${BASE_CONFIG_DIR}/starship.toml"
export SHELDON_CONFIG_FILE="${BASE_CONFIG_DIR}/sheldon-plugins.toml"

# Activate mise 
if (( ${+VSCODE_INJECTION} )); then
	eval "$(${HOME}/.local/bin/mise activate zsh --shims)"
else
	eval "$(${HOME}/.local/bin/mise activate zsh )"
fi 

# ENV var for sheldon
export SHELDON_PROFILE="$(uname)"

eval "$(sheldon source)"

# 1. パスの設定
BUNDLE_FILE="$DOTFILES_DIR/custom.bundle.zsh"
CUSTOM_DIR="$DOTFILES_DIR/custom"

# 2. フォールバック・ロジック
# バンドルファイルが存在しない場合に自動生成
if [[ ! -f "$BUNDLE_FILE" ]]; then
    echo "⚡️ Zsh bundle not found. Building for the first time..."
    
    # バンドル開始（既存ファイルを空にして作成）
    : > "$BUNDLE_FILE"
    
    # ファイルを順番に結合
    # init.zsh が必要なら最初に入れる（ただし内部の source ループは無効化される必要あり）
    # ここではシンプルに custom/*.zsh を番号順に結合します
    for f in "$CUSTOM_DIR"/[0-9][0-9]-*.zsh; do
        echo "  Appending $f..."
        echo "# --- Source: ${f:t} ---" >> "$BUNDLE_FILE"
        cat "$f" >> "$BUNDLE_FILE"
        echo -e "\n" >> "$BUNDLE_FILE"
    done

    # 3. 最適化 (ViteでいうところのMinifyに近い)
    # zshのバイトコードにコンパイルして読み込み速度を最大化
    # zcompile "$BUNDLE_FILE"
    
    echo "✅ Bundle created: $BUNDLE_FILE"
fi

# 4. バンドルされたファイルを読み込む
source "$BUNDLE_FILE"

autoload -Uz compinit && compinit

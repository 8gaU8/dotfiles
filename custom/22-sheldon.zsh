#! /usr/bin/env zsh

export SHELDON_CONFIG_FILE="${BASE_CONFIG_DIR}/sheldon-plugins.toml"

# ENV var for sheldon
export SHELDON_PROFILE="$(uname)"

eval "$(sheldon source)"

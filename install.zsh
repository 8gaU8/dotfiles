#! /usr/bin/env zsh

INSTALL_PATH="${HOME}/dotfiles"
git clone https://github.com/8gau8/dotfiles "${INSTALL_PATH}"
ln -s "${INSTALL_PATH}/config/mise.global.toml" "${HOME}/.config/mise/config.toml"
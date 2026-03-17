#! /usr/bin/env zsh

INSTALL_PATH="${HOME}/dotfiles"
git clone https://github.com/8gau8/dotfiles "${INSTALL_PATH}"
# install mise if not exists
if ! command -v mise &> /dev/null; then
    echo "Mise not found. Installing..."
    curl https://mise.run | sh
else
    echo "Mise is already installed."
fi
cd "${INSTALL_PATH}" && \
    mise reinstall && \
    cd - > /dev/null

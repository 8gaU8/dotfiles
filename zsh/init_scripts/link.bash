#! /bin/bash

set -o errexit
set -o nounset
set -o pipefail


cd "$(dirname "${BASH_SOURCE[0]}")"
_init_scripts_dir="$(dirname "${BASH_SOURCE[0]}")"

zshdir="$(dirname "${_init_scripts_dir}")"

ln -sf "${zshdir}/zshrc" "${HOME}/.zshrc"
#! /bin/bash

set -o errexit
set -o nounset
set -o pipefail

_init_scripts_dir="$(dirname "${BASH_SOURCE[0]}")"
_zshdir="$(dirname "${_init_scripts_dir}")"

cd "${_zshdir}"
zshdir="$(pwd)"

rm -f "${zshdir}"/custom.bundle.zsh*

rm -f "${HOME}"/.zshrc.zwc
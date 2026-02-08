#! /usr/bin/env zsh

_PY_HOME="${HOME}/.uv-home"

[[ -d "${_PY_HOME}" ]] || {
	warn "Creating homeuv environment at ${_PY_HOME}"
	mkdir -p "${_PY_HOME}"
	cd "${_PY_HOME}" && uv init --name homeuv
}

function homepy() {
	uv run --project $_PY_HOME $@
}

function homepy-add() {
	uv add --project $_PY_HOME $@
}

function homepy-remove() {
	uv remove --project $_PY_HOME $@
}

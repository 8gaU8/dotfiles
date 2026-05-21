activation_cache_file="${HOME}/.cache/zsh-activation_cache.zsh"

function evalcache() {
	echo "Evaluating: $*"
	# exit if the command is not available
	if ! command -v "$1" &>/dev/null; then
		echo "Command $1 not found, skipping."
		return
	fi
	"$@" >>"$activation_cache_file"
}

# if no cache file exists, create an empty one
if [[ ! -f "$activation_cache_file" ]]; then
	evalcache starship init zsh
	evalcache /opt/homebrew/bin/brew shellenv
	evalcache try init ~/src/tries
	evalcache fzf --zsh
	evalcache zoxide init zsh --cmd cd
fi

source "$activation_cache_file"

on_demand_completion() {
	local cmd_name=$1
	local completion_command=$2
	local function_name="_${cmd_name}"
	local comp_cmd_name="${completion_command%% *}"

	# exit if the command is not available
	if ! command -v "$comp_cmd_name" &>/dev/null; then
		return
	fi

	eval "function $function_name() {
		if ! command -v "$comp_cmd_name" &> /dev/null; then
		return
		fi
		unfunction '$function_name'
		eval \"\$(eval $completion_command)\"
		\$_comps[$cmd_name]
	}"

	compdef $function_name $cmd_name
}

on_demand_completion "tailscale" "tailscale completion zsh"
on_demand_completion "uv" "uv generate-shell-completion zsh"
on_demand_completion "uvx" "uvx --generate-shell-completion=zsh"
on_demand_completion "gh" "gh completion -s zsh"
on_demand_completion "mise" "mise completion zsh"
on_demand_completion "pnpm" "pnpm completion zsh"
on_demand_completion "sheldon" "sheldon completions --shell zsh"
on_demand_completion "rustup" "rustup completions zsh rustup"
on_demand_completion "cargo" "rustup completions zsh cargo"
on_demand_completion "starship" "starship completions zsh"
on_demand_completion "docker" "docker completion zsh"

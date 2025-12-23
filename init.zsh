# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Path to Customization
export ZSH_CUSTOM="$HOME/zsh-dotfiles/custom"

plugins=(
    zsh-autosuggestions
    zsh-syntax-highlighting
)

ZSH_THEME="ultima"

source $ZSH/oh-my-zsh.sh
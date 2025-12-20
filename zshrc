# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Path to Customization
export ZSH_CUSTOM="$HOME/zsh-dotfiles/custom"


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

plugins=(
    git
    #python
    zsh-autosuggestions
    zsh-syntax-highlighting
    docker
)

export LOGGER_LEVEL=4

ZSH_THEME="robbyrussell"
ZSH_THEME="ultima"

# 名前で色を付けるようにする
autoload colors
colors
 
# LS_COLORSを設定しておく
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
 
# ファイル補完候補に色を付ける
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# # completion setting
# autoload -Uz compinit
# ZSH_COMPDUMP=~/.cache/zsh/.zcompdump-${ZSH_VERSION}
# compinit -d $ZSH_COMPDUMP
autoload -U compinit && compinit -i

source $ZSH/oh-my-zsh.sh

# use try
eval "$(ruby ~/.local/try.rb init ~/src/tries)"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/hagayuya/.lmstudio/bin"
# End of LM Studio CLI section

# Added by Antigravity
export PATH="/Users/hagayuya/.antigravity/antigravity/bin:$PATH"

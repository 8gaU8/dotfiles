# Oh! my zsh Custom files

## Usage

1. clone this repository
```bash
git clone --recurse-submodules  https://github.com/8gaU8/zsh-dotfiles/ ~/zsh-dotfiles
```

2. link custom files to ~/.zshrc
```bash
cd $HOME/zsh-dotfiles/custom/themes && ln -s ultima-shell/ultima.zsh-theme ultima.zsh-theme

```

3. update .zshrc to source custom files
```bash
echo "source ~/zsh-dotfiles/zshrc" > ~/.zshrc
```
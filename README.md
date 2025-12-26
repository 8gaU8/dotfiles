# ZSH dotfiles

## Usage
1. Install mise-en-place
2. clone this repository
```bash
git clone --recurse-submodules  https://github.com/8gaU8/zsh-dotfiles/ ~/zsh-dotfiles
```

3. update .zshrc to source custom files
```bash
echo "source ~/zsh-dotfiles/zshrc" > ~/.zshrc
```

4. (optional if it doesnt work) link custom files to ~/.zshrc
```bash
cd $HOME/zsh-dotfiles/custom/themes && ln -s ultima-shell/ultima.zsh-theme ultima.zsh-theme

```

## TODO

- Mise が先か Sheldon が先か問題
- Sheldon は mise:cargo でインストールしている
- mise をアクティベーションしないと sheldon は使えない
- しかし mise のアクティベーションは sheldon のプラグインとして行っている
- 現状は.zprofileでmiseをアクティベーションしてからzshを起動することで回避している

# dotfiles

## Usage

1. Install mise-en-place and sheldon
2. clone this repository

```bash
git clone https://github.com/8gaU8/dotfiles/ ~/dotfiles
```

3. update .zshrc to source custom files

```bash
echo "source ~/dotfiles/zshrc" > ~/.zshrc
```

## Scripts

1. `zshrc`: entry point
   - Defines a custom `source` command. 
   - Bundle scripts in `custom/` and compileit.
2. `custom/*.zsh`:
   1. `custom/10-utils.zsh`
      - Defines utility functions for path additions and completions.
   2. `custom/21-mise.zsh`
      - Activates mise based on environments.
   3. `custom/22-sheldon.zsh`
      - Defines sheldon config location and a profile. Then activates it.
   4. `custom/23-starship.zsh`
      - Defines starship config location. Then activates it.
   5. `custom/40-path.zsh`
      - Configures the global path variable
   6. `custom/50-activations.zsh`
      - Activates tools (brew, tobi/try, fzf, zoxide) using a custom function loaded via sheldon.
   7. `custom/60-completions.zsh`
      - Load completions using a custom function defined at `10-utils.zsh`.
   8. `custom/70-alias.zsh`
      - Defines alias.
   9. `custom/80-homeuv.zsh`
      - Global python environment
   10. `custom/90-misc.zsh`
       - Misc settings
   11. `custom/99-zshopt.zsh`
       - ZSH options

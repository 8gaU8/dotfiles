# dotfiles

## Installation steps
1. Install mise
   ```
   curl https://mise.run | sh
   ```
2. Clone this repo at `${HOME}/dotfiles/`

3. Create bootstrap zshrc
   ```
   echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
   ```

4. Install dependencies with `mise`

5. Run `mise tasks reinstall` at ~/dotfiles

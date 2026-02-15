# dotfiles

## Usage

### Docker (Recommended for Development)

Use Docker to quickly set up a development environment with all dependencies pre-installed:

**Quick Start:**

```bash
# Clone this repository
git clone https://github.com/8gaU8/dotfiles/
cd dotfiles

# Start the development environment
docker compose up -d
docker compose exec dev zsh
```

**What's included in the Docker environment:**
- Ubuntu 24.04 LTS base image
- mise-en-place (version 2024.12.17) pre-installed
- zsh configured with all custom scripts
- All tools from `config/mise.global.toml` (installed on first run)
- Volume mounts for live development

**First Run:**
On the first run, the container will automatically install all mise tools defined in `config/mise.global.toml`. This includes:
- Development tools (node, python, rust, etc.)
- CLI utilities (bat, eza, fzf, gh, starship, etc.)
- Package managers (pnpm, pipx, uv, etc.)

**Docker Commands:**

```bash
# Start container in background
docker compose up -d

# Access the shell
docker compose exec dev zsh

# Stop the container
docker compose down

# Rebuild after Dockerfile changes
docker compose build

# Remove all data (including installed tools)
docker compose down -v

# Or use plain docker commands
docker build -t dotfiles-dev .
docker run -it --rm -v $(pwd):/root/dotfiles dotfiles-dev
```

**Environment Variables:**
You can set `GITHUB_TOKEN` to increase GitHub API rate limits during mise tool installation:

```bash
# In docker-compose.yml, add under 'environment:' section
GITHUB_TOKEN=your_github_token_here
```

### Manual Installation

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

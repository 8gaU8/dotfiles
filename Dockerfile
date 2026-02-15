# Development environment for dotfiles with mise support
FROM ubuntu:24.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install base dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    zsh \
    ca-certificates \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install mise-en-place
# We'll download a specific version directly
RUN MISE_VERSION="2024.12.17" && \
    wget -q "https://github.com/jdx/mise/releases/download/v${MISE_VERSION}/mise-v${MISE_VERSION}-linux-x64" -O /usr/local/bin/mise && \
    chmod +x /usr/local/bin/mise

# Set up mise in PATH
ENV PATH="/root/.local/bin:/root/.local/share/mise/shims:/usr/local/bin:${PATH}"

# Create config directory for mise
RUN mkdir -p /root/.config/mise

# Set working directory
WORKDIR /root/dotfiles

# Copy dotfiles to container
COPY . /root/dotfiles

# Make entrypoint executable
RUN chmod +x /root/dotfiles/docker-entrypoint.sh

# Create symbolic link for mise global configuration
RUN ln -sf /root/dotfiles/config/mise.global.toml /root/.config/mise/config.toml

# Set up zsh configuration
RUN echo "source /root/dotfiles/zshrc" > /root/.zshrc

# Note: Tools will be installed on first run to avoid build-time rate limits
# Users can run 'mise install' after starting the container

# Set zsh as the default shell for interactive use
ENV SHELL=/bin/zsh

# Use custom entrypoint for better first-run experience
ENTRYPOINT ["/root/dotfiles/docker-entrypoint.sh"]

# Default command is to start interactive shell
CMD []

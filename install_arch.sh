#!/bin/bash
set -e
set -x

# Update system
yay -Syu

# Install base packages
yay -S --needed python3 rustup golang fish ccache sccache zoxide fzf ripgrep tree-sitter-cli fortune-mod lolcat just rcm inetutils unzip
go install github.com/jesseduffield/lazygit@latest
rustup install stable

# Install nvm
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install jorgebucaran/nvm.fish
nvm install latest


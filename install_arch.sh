#!/bin/bash
set -e
set -x

# Update system
sudo pacman -Syu

# Install yay
sudo pacman -S --needed git base-devel
pushd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
popd

# Install base packages
yay -S --needed python3 \
    neovim \
    rustup \
    go \
    fish \
    ccache \
    sccache \
    zoxide \
    fzf \
    ripgrep \
    tree-sitter-cli \
    fortune-mod \
    lolcat \
    just \
    rcm \
    inetutils \
    unzip \
    lua51 \
    nerd-fonts \
    cmake \
    clang \
    ninja
go install github.com/jesseduffield/lazygit@latest
rustup install stable

# Install nvm
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install jorgebucaran/nvm.fish
nvm install latest


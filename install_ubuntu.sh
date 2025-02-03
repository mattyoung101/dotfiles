#!/bin/bash
set -e
set -x

# Assumes Neovim is built from source
# Designed for Ubuntu 24.04, probably works on other Ubuntus too

# Update system
sudo apt update

# Install base packages
sudo apt install python3 \
    fish \
    ccache \
    fzf \
    ripgrep \
    fortune-mod \
    lolcat \
    rcm \
    unzip \
    lua5.1 \
    curl \
    wget \
    sudo \
    fd-find \
    software-properties-common \
    rustup \
    golang-go \
    just \
    zoxide \
    build-essential \
    clang \
    cmake \
    ninja-build

# rustup
rustup install stable

# go
go install github.com/jesseduffield/lazygit@latest

# zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# tree-sitter-cli
cargo install --locked tree-sitter-cli

# WezTerm
# TODO keyring
# sudo mkdir -p /etc/apt/keyrings
# echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
# sudo apt update
# sudo apt install wezterm

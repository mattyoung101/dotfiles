#!/bin/bash
set -e
set -x

# Assumes Neovim is built from source
# Designed for Ubuntu 20.04, probably works on other Ubuntus too

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
    software-properties-common

# rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME/.cargo/env"
rustup install stable

# go
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt update
sudo apt install golang-go
go install github.com/jesseduffield/lazygit@latest

# zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# tree-sitter-cli
cargo install --locked tree-sitter-cli

# just
cargo install just

# WezTerm (20.04)

# TODO: Doesn't work

# pushd /tmp
# wget https://github.com/wez/wezterm/releases/download/20240203-110809-5046fc22/wezterm-20240203-110809-5046fc22.Ubuntu20.04.deb
# sudo dpkg -i wezterm-20240203-110809-5046fc22.Ubuntu20.04.deb
# popd

# sudo mkdir -p /etc/apt/keyrings
# echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
# sudo apt update
# sudo apt install wezterm

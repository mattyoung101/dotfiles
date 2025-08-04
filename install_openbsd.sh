#!/bin/ksh
set -e
set -x

# OpenBSD: use a less shitty mirror
set -x PKG_PATH https://mirror.aarnet.edu.au/pub/OpenBSD/7.7/packages-stable/amd64/

doas pkg_add autoconf \
    automake \
    bear \
    ccache \
    clang-tools-extra \
    fish \
    rust \
    go \
    jq \
    neovim \
    rcm \
    ripgrep \
    fzf \
    python3 \
    wget \
    cmake

# fd-find
cargo install fd-find

# just
cargo install just

# lazygit
go install github.com/jesseduffield/lazygit@latest

# zoxide
cargo install zoxide

# tree-sitter-cli
cargo install tree-sitter-cli

# fish_add_path ~/go/bin
# fish_add_path ~/.cargo/bin

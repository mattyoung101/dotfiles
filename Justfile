IGNORE_LIST := '-x Justfile -x LICENSE.txt -x README.md -x backups'

default:
    @just --list

# Show dotfiles that would be installed
show:
    lsrc {{IGNORE_LIST}}

# Install dotfiles
install:
    rcup -v {{IGNORE_LIST}}

# Uninstall dotfiles
uninstall:
    rcdn -v {{IGNORE_LIST}}

# Bump submodules
update:
    git submodule update --init --recursive --remote

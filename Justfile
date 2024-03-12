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

# Bump submodules and install any new files
update:
    git submodule update --init --recursive --remote
    @just install

# Bump submodules and push
updatepush: update
    git add -A
    git commit -m "Bump submodules"
    git push

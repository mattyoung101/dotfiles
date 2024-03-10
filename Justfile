default:
    @just --list

# Show dotfiles that would be installed
show:
    lsrc -x Justfile -x LICENSE.txt -x README.md -x backups

# Install dotfiles
install:
    rcup -v -x Justfile -x LICENSE.txt -x README.md -x backups

# Uninstall dotfiles
uninstall:
    rcdn -v -x Justfile -x LICENSE.txt -x README.md -x backups



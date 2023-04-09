# NVIM Setup

We do a little [theivery](https://github.com/nvim-lua/kickstart.nvim).

## NOTES
- Install [oh-my-zsh](https://ohmyz.sh/).
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

- Install [Powerlevel10k](https://github.com/romkatv/powerlevel10k#oh-my-zsh) theme.
```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

Add `ZSH_THEME="powerlevel10k/powerlevel10k"` to `~/.zshrc`.

```
brew tap homebrew/cask-fonts && brew install --cask font-jetbrains-mono-nerd-font
# don't forget to set iTerm2 to use this font and to enable use ligatures
# and also restart
```

- Install ripgrep
```
brew install ripgrep
```

- Install npm
```
brew install node
```

I've missed a lot of dependencies so oh well. Whoops

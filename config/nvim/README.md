# NVIM Setup

Built off [ kickstart.nvim ]( https://github.com/nvim-lua/kickstart.nvim ). Made for my own
[ iTerm2 ]( https://iterm2.com/ ) setup using [ oh-my-zsh ]( https://ohmyz.sh/ ) but should 
be able to be loaded onto anything. Also includes my tmux configuration which I basically 
just stole from [ Josean Martinez ]( https://youtu.be/U-omALWIBos ) with the most minor of 
changes. It contains all the usual stuff like a package manager 
([ lazy.nvim ]( https://github.com/folke/lazy.nvim )), fuzzy finder 
([ telescope.nvim ]( https://github.com/nvim-telescope/telescope.nvim ) and 
[ telescope-fzf-native.nvim ]( https://github.com/nvim-telescope/telescope-fzf-native.nvim )),
tree sitter ([ nvim-treesitter ]( https://github.com/nvim-treesitter/nvim-treesitter )) and
some more, but that's boring, so here's a list of the stuff I've added.

### Theme

**[ starry.nvim ]( https://github.com/ray-x/starry.nvim )**
- Lets me swap between a bunch of different themes without having to reinstall new ones

**[ dashboard-nvim ]( https://github.com/nvimdev/dashboard-nvim )**
- Dashboard plugin, just so it looks nice when I first open this up

**[ transparent.nvim ]( https://github.com/xiyaowong/transparent.nvim )**
- For when I have a fun background

### Editing QoL

**[ nvim-autopairs ]( https://github.com/windwp/nvim-autopairs )**
- Bracket autocompletion - can play up sometimes but has been mostly nice to me

**[ nvim-surround ]( https://github.com/kylechui/nvim-surround )**
- Plugin to surround selected blocks - super useful for parentheses and the like

**[ git-conflict ]( https://github.com/akinsho/git-conflict.nvim )**
- Highlights and visualises git conflicts

**[ cmp-spell ]( https://github.com/f3fora/cmp-spell )**
- Spell checker because I'm and engineer and can't spell

**[ markdown-preview.nvim ]( https://github.com/iamcco/markdown-preview.nvim )**
- Plugin to preview markdown

### Navigation

**[ neo-tree.nvim ]( https://github.com/nvim-neo-tree/neo-tree.nvim )**
- File tree is a bit nicer to look at than netrw

**[ symbols-outline.nvim ]( https://github.com/simrat39/symbols-outline.nvim )**
- Shows tree of all the symbols in the currently open file

**[ nvim-tmux-navigation ]( https://github.com/alexghergh/nvim-tmux-navigation )**
- Used for tmux integration

### Other

**[ vim-wakatime ]( https://github.com/wakatime/vim-wakatime )**
- Why do I even look at these stats, I barely even program

**[ ros-nvim ]( https://github.com/taDachs/ros-nvim )**
- Lets me finally navigate through launch links and peek at message definitions

**[ cmp-matlab ]( https://github.com/mstanciu552/cmp-matlab )**
- MATLAB completion source for nvim-cmp, not super extensive but it does the trick

There are a few others included but I don't really use them so I won't mention them.

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

- Install tpm for tmux integration
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

I've missed a lot of dependencies so oh well. Whoops

# NVIM Setup

Built off [Ethan's vim config](https://github.com/nvim-lua/kickstart.nvim) with some changes to my liking
and explicit support for Linux. I will attempt to keep this synced with his upstream.

It contains all the usual stuff like a package manager 
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

**[darcula-solid.nvim](https://github.com/briones-gabriel/darcula-solid.nvim)**
- I've always been a huge fan of IntelliJ's Darcula theme, so here it is!

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

**[ nvim-ufo ]( https://github.com/kevinhwang91/nvim-ufo )**
- Plugin for folding code sections - works out of the box which is super nice

**[auto-save.nvim](https://github.com/Pocco81/auto-save.nvim)**
- Autosave, because you never know when your power cord gets yanked :)

**[lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)**
- Git integration, allows you to launch [lazygit](https://github.com/jesseduffield/lazygit), a seemingly pretty
cool looking git TUI

**[nvim-ts-rainbow2](https://github.com/HiPhish/nvim-ts-rainbow2)**
- Adds bracket pair colourisation, as in VSCode. I personally quite like this feature, and it should be pretty
fast as it interfaces with treesitter directly.

### Navigation

**[ neo-tree.nvim ]( https://github.com/nvim-neo-tree/neo-tree.nvim )**
- File tree is a bit nicer to look at than netrw

**[ symbols-outline.nvim ]( https://github.com/simrat39/symbols-outline.nvim )**
- Shows tree of all the symbols in the currently open file

**[ nvim-tmux-navigation ]( https://github.com/alexghergh/nvim-tmux-navigation )**
- Used for tmux integration

**[ oil.nvim ]( https://github.com/stevearc/oil.nvim )**
- So this is pretty cool, you can navigate through files in a netrw like interface but can add, rename and remove files just by editing the lines in the buffer

**[barbar.nvim](https://github.com/romgrk/barbar.nvim)**
- Elegant tab navigation for nvim, a nice QoL improvement for me

### Other

**[ vim-wakatime ]( https://github.com/wakatime/vim-wakatime )**
- Accurate statistics about how much time I _didn't_ spend outside

**[ ros-nvim ]( https://github.com/taDachs/ros-nvim )**
- Lets me finally navigate through launch links and peek at message definitions

**[ cmp-matlab ]( https://github.com/mstanciu552/cmp-matlab )**
- MATLAB completion source for nvim-cmp, not super extensive but it does the trick

There are a few others included but I don't really use them so I won't mention them.

## Installation
1. Install the latest Neovim, use the unstable PPA: https://launchpad.net/~neovim-ppa/+archive/ubuntu/unstable
2. Clone the repo as ~/.config/nvim, for example: `git clone git@github.com:mattyoung101/nvim-setup.git ~/.config/nvim`
3. (If using nvim.fish): Edit `~/.config/fish/config.fish` to source nvm on startup: `nvm -s use latest`
4. On Linux Mint, the default terminal font is DejaVu Sans Mono (even though the font is just listed as "Monospace").
You can prove this to yourself by doing `fc-match monospace`. You will need to install the NerdFont patch for this
so that the icons show: https://www.nerdfonts.com/font-downloads
5. Change the monospace font in System Settings to the DejaVu Sans Mono Nerd font.

## Wishlist (plugins to be added and changes to make)
- SystemVerilog LSP
    - Probably either svls or Veridian
    - Must have completion (even if that requires universal ctags)
    - May require custom plugin or us to cope with NodeJS LSPs
- Better markdown
    - Auto complete like in IntelliJ (e.g. when you press enter it'll keep the list going)
    - Show stuff like _italics_ and **bold** in actual italics and bold in the editor
    - May require custom plugin
- Better spelling
    - CamelCase and camelCase and snake_case should work as word separators
    - Add more dictionaries from "cspell" (without using cspell because I don't want to touch nodejs on a ten
    foot pole) -> this will require compiling custom spell files
    - Fix this: the word "Ethan" is marked as valid, but "Ethan's" (with the apostrophe s) is invalid. We should
    ignore words that 
    - Fully uppercase words (i.e. acronyms) should be ignored
- Make the TODO plugin work with Markdown (basically regex for "TODO" everywhere)
- Make the TODO plugin highlighting look less ugly
- Telescope search results should be centred on screen

**Done:**

- (DONE) Autosave
    - TODO: Configure it so that if you create a new file like `nvim test.txt`, it does _NOT_ autosave
    - TODO: make it not autosave as often
- (DONE) Tabs
- (DONE) Git integration
- (DONE) File navigation menu should open by default on the left hand side
    - Technically I changed nothing, you just do `nvim .` instead of `nvim`

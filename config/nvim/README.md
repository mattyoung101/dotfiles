# NVIM Setup

Matt's configuration for neovim 0.9.0.

Built off [Ethan's vim config](https://github.com/nvim-lua/kickstart.nvim) with some changes to my liking
and explicit support for Linux, plus a whole lot more plugins (I love plugins!) - so do expect longer boot
times.

It contains all the usual stuff like a package manager 
([ lazy.nvim ]( https://github.com/folke/lazy.nvim )), fuzzy finder 
([ telescope.nvim ]( https://github.com/nvim-telescope/telescope.nvim ) and 
[ telescope-fzf-native.nvim ]( https://github.com/nvim-telescope/telescope-fzf-native.nvim )),
tree sitter ([ nvim-treesitter ]( https://github.com/nvim-treesitter/nvim-treesitter )) and
some more, but that's boring, so here's a list of the stuff I've added.

Big thanks again to Ethan for the original config and getting me into Neovim.

### Theme

**[ dashboard-nvim ]( https://github.com/nvimdev/dashboard-nvim )**
- Dashboard plugin, just so it looks nice when I first open this up

**[ transparent.nvim ]( https://github.com/xiyaowong/transparent.nvim )**
- For when I have a fun background

**[darcula-solid.nvim](https://github.com/briones-gabriel/darcula-solid.nvim)**
- I've always been a huge fan of IntelliJ's Darcula theme, so here it is! This isn't a completely faithful
recreation like https://github.com/doums/darcula, which I might try in future

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

**[rainbow-delimiters.sv](https://github.com/HiPhish/rainbow-delimiters.nvim)**
- Adds bracket pair colourisation, as in VSCode. I personally quite like this feature, and it should be pretty
fast as it interfaces with treesitter directly. I also contributed SystemVerilog & Verilog support to this
plugin so you can use it for HDL work :)

**[suda.nvim](https://github.com/lambdalisue/suda.vim)**
- Simple script that allows reading/writing files with root permissions. Useful for system configuration.

### Navigation

**[ neo-tree.nvim ]( https://github.com/nvim-neo-tree/neo-tree.nvim )**
- File tree is a bit nicer to look at than netrw

**[ symbols-outline.nvim ]( https://github.com/simrat39/symbols-outline.nvim )**
- Shows tree of all the symbols in the currently open file

**[ nvim-tmux-navigation ]( https://github.com/alexghergh/nvim-tmux-navigation )**
- Used for tmux integration

**[barbar.nvim](https://github.com/romgrk/barbar.nvim)**
- Elegant tab navigation for nvim, a nice QoL improvement for me

### Other

**[ vim-wakatime ]( https://github.com/wakatime/vim-wakatime )**
- Accurate statistics about how much time I _didn't_ spend outside

**[ ros-nvim ]( https://github.com/taDachs/ros-nvim )**
- Lets me finally navigate through launch links and peek at message definitions

**[ cmp-matlab ]( https://github.com/mstanciu552/cmp-matlab )**
- MATLAB completion source for nvim-cmp, not super extensive but it does the trick

**Additional changes:**
- Add SystemVerilog language server
- Change theme to Darcula (my favourite theme of all time)
- 110 character side ruler, this is the width I use when editing
- Some other misc changes, e.g. no relative line numbers, etc. 

**Note:** There are a few extra plugins that I may have forgot to include on this list.

## Installation
This repo is mainly managed as a submodule through the [dotfiles](https://github.com/mattyoung101/dotfiles)
repo. You should clone that repo, and edit the `config/nvim` repo directly as a submodule. Then follow the
instructions there to install the dotfiles. Once that's done:

1. Install the latest **stable** Neovim (currently 0.9.0 as of 27 May 2023). 
3. (If using nvm.fish): Edit `~/.config/fish/config.fish` to source nvm on startup: `nvm -s use latest`
4. On Cinnamon, the default terminal font is DejaVu Sans Mono (even though the font is just listed as "Monospace").
You can prove this to yourself by doing `fc-match monospace`. You will need to install the NerdFont patch for this
so that the icons show: https://www.nerdfonts.com/font-downloads
5. Change the monospace font in System Settings to the DejaVu Sans Mono Nerd font.
6. Install [LazyGit](https://github.com/jesseduffield/lazygit), which may require installing go
7. You should also have a gcc/clang and the latest stable rust (probably with rustup) on your system
8. Also install `fzf` and `ripgrep`

## Wishlist (plugins to be added and changes to make)
**Needs doing:**

- Better spelling
    - Fix this: the word "Ethan" is marked as valid, but "Ethan's" (with the apostrophe s) is invalid. We should
    ignore words that 
    - Fully uppercase words (i.e. acronyms) should be ignored
- Telescope search results should be centred on screen when you navigate to them
- Pressing enter in a list of Markdown items should auto-insert a "-" on the next line
- Filetree should auto refresh git status (it doesn't seem to reload when git status or even files in directory
are changed atm)
- LSP inlay hints (this is like how CLion will annotate the parameters of function calls in grey text)
    - Requires bleeding edge neovim: https://www.reddit.com/r/neovim/comments/115uoft/comment/jov7vi7/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
    - https://github.com/lvimuser/lsp-inlayhints.nvim
    - https://github.com/simrat39/inlay-hints.nvim
- Each variable should get a unique colour (like what CLion calls "semantic highlighting", which is separate
from LSP semantic highlighting). This will require a custom plugin or custom Lua.

**Partially done:**

- Semantic highlighting, like in IntelliJ/CLion
    - Sort of works atm, but needs some more customisation from my end to work with the darcula-solid theme better
- SystemVerilog LSP
    - Currently using IMC's svlangserver, but I'm unhappy with this and may write my own from scratch based
    on slang
    - Veridian: eh, would be cool but doesn't seem to accept my code
    - svls: only provides linting
    - verible: same as svls, only provides lint
    - Note: Currently working on my own LSP

## Cheatsheet
Common operations I forget:

- **Comment out a section of code:** visual select, g, c
- **Search in current buffer:** space, slash
- **Quit everything:** :qa and :wqa
- **Find a file:** space, s, f
- **Cancel autocomplete:** Ctrl+E
- **Create a new file in neotree:** a (read [documentation](https://github.com/nvim-neo-tree/neo-tree.nvim#longer-example-for-packer))
- **Rename a file in neotree:** r
- **Delete a word (like ctrl+bkspce):** ctrl+w
- **Go to beginning of line:** ^ (shift 6)
- **Apply fix:** space, c, a
- **Yank whole document:** ggyG
- **Go to beginning:** gg
- **Go to end:** shift g

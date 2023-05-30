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
- Some other misc changes, e.g. no relative line numbers, etc. See my wishlist below for more details.

**Note:** There are a few extra plugins that I may have forgot to include on this list.

## Installation
1. Install the latest **stable** Neovim (currently 0.9.0 as of 27 May 2023). I suggest building from source, it's
very easy. Instructions are here: https://github.com/neovim/neovim/wiki/Building-Neovim
    - It's important that you _don't_ use the unstable PPA, as I suggested previously, because there's a few bugs
    on bleeding edge unstable nvim (who'da thunk it) that impact usability. Details are below, it's currently just
    an issue with the rainbow bracket splugin.
2. Clone the repo as ~/.config/nvim, for example: `git clone git@github.com:mattyoung101/nvim-setup.git ~/.config/nvim`
3. (If using nvim.fish): Edit `~/.config/fish/config.fish` to source nvm on startup: `nvm -s use latest`
4. On Linux Mint, the default terminal font is DejaVu Sans Mono (even though the font is just listed as "Monospace").
You can prove this to yourself by doing `fc-match monospace`. You will need to install the NerdFont patch for this
so that the icons show: https://www.nerdfonts.com/font-downloads
5. Change the monospace font in System Settings to the DejaVu Sans Mono Nerd font.

## Wishlist (plugins to be added and changes to make)
**Needs doing:**

- Better spelling
    - CamelCase and camelCase and snake_case should work as word separators
    - Add more dictionaries from "cspell" (without using cspell because I don't want to touch nodejs on a ten
    foot pole) -> this will require compiling custom spell files
    - Fix this: the word "Ethan" is marked as valid, but "Ethan's" (with the apostrophe s) is invalid. We should
    ignore words that 
    - Fully uppercase words (i.e. acronyms) should be ignored
    - Worst case, this may require a custom plugin or even LSP (somehow?), but would be an interesting exercise
    in data structures so I'm not complaining :)
- Make the TODO plugin work with Markdown (basically regex for "TODO" everywhere)
- Make the TODO plugin highlighting look less ugly
- Telescope search results should be centred on screen
- Git integration in the file tree doesn't seem to work until restart (modified files are not shown in orange)
- Figure out how to create files in neovim file tree
- Add keybindings for barbar tab navigation
- Bind ctrl+backspace to delete last word

**Partially done:**

- When closing certain lua files with nvim-ts-rainbow2 and barbar enabled, there is an exception thrown
    - Can only reproduce with lua/custom/plugins/** files, nothing else atm
    - It's this bug here: https://github.com/HiPhish/nvim-ts-rainbow2/issues/40
    - They are blaming upstream neovim, questionable, guess we'll wait til it gets resolved in up/down stream
    - Partially fixed by downgrading to 0.9.0 (build from source), which works, but not super ideal
    - This will be less bad once I move to Arch and can use actually up to date packages
- SystemVerilog LSP
    - Currently using IMC's svlangserver, but I'm unhappy with this and may write my own from scratch based
    on slang

**Done:**

- (DONE) Autosave
    - TODO: Configure it so that if you create a new file like `nvim test.txt`, it does _NOT_ autosave
    - TODO: make it not autosave as often
- (DONE) Tabs
- (DONE) Git integration
- (DONE) File navigation menu should open by default on the left hand side
    - Technically I changed nothing, you just do `nvim .` instead of `nvim`
- (DONE) Better markdown
    - Show stuff like _italics_ and **bold** in actual italics and bold in the editor
    - This didn't end up actually requiring a custom plugin, I just added the markdown_inline language from
    here: https://github.com/MDeiml/tree-sitter-markdown (as mentioned here: https://github.com/nvim-treesitter/nvim-treesitter)

## Cheatsheet
Common operations I forget:

- **Comment out a section of code:** visual select, g, c
- **Search in current buffer:** space, slash
- **Cut text:** visual select, d
- **Copy text:** visual select, y (yank)
- **Quit everything:** :qa
- **Find a file:** space, s, f
- **Cancel autocomplete:** Ctrl+E
- **Create a new file in neotree:** TODO

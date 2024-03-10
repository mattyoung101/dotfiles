# Neovim Setup
Matt's configuration for neovim 0.9.0.

Built off [Ethan's vim config](https://github.com/nvim-lua/kickstart.nvim) with some changes to my liking
and explicit support for Linux, plus a whole lot more plugins (I love plugins!) - so do expect longer boot
times.

Big thanks again to Ethan for the original config and getting me into Neovim.

_There used to be a list of plugins/themes here, but there's so many now it's gotten out of hand. I guess RTFL
(read the flipping Lua!!!!!)._

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
**OUTDATED**

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

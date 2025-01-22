# Neovim Setup
Matt's configuration for neovim 0.10.0.

Originally built off [Ethan's vim config](https://github.com/nvim-lua/kickstart.nvim) in 2024, but has since
diverged significantly.

Big thanks again to Ethan for the original config and getting me into Neovim.

## Installation
See parent directory.

## Wishlist (plugins to be added and changes to make)
**OUTDATED**

- Better spelling
    - Fix this: the word "Ethan" is marked as valid, but "Ethan's" (with the apostrophe s) is invalid. We should
    ignore words that 
    - Fully uppercase words (i.e. acronyms) should be ignored
- Filetree should auto refresh git status (it doesn't seem to reload when git status or even files in directory
are changed atm)
- Each variable should get a unique colour (like what CLion calls "semantic highlighting", which is separate
from LSP semantic highlighting). This will require a custom plugin or custom Lua.

# Dotfiles
dotfiles lfg!!!!!!!!!!!!!!

This setup is based on the Fish shell, WezTerm terminal emulator, and Neovim editor. My DE is currently KDE
Plasma 6 on Arch Linux.

## How to use
### Prerequisites
First, clone into `~/.dotfiles`: 

```
git clone --recurse-submodules -j8 git@github.com:mattyoung101/dotfiles.git ~/.dotfiles
```

The dotfiles are managed using [rcm](https://github.com/thoughtbot/rcm) and
[Just](https://github.com/casey/just), which you can install using something like `yay -S rcm just`.

In addition, you will need the following tools/libraries/languages/frameworks installed on your system (not
yet an exhaustive list):
- Just
- rcm
- Python 3, including venv
- Rust
- Golang
- fish shell
- ccache
- sccache
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [nvm.fish](https://github.com/jorgebucaran/nvm.fish)
- [WezTerm](https://wezfurlong.org/wezterm/index.html)
- [LazyGit](https://github.com/jesseduffield/lazygit)
- [fzf](https://github.com/junegunn/fzf)
- ripgrep
- tree-sitter-cli
- fortune-mod
- lolcat
- Lua 5.1 (lua51 on Arch)
- ...some more I probably forgot and will discover on my next fresh install

### Installing
First, confirm what would be installed using `just show`.

Install using `just install`. 

> [!WARNING]
> No backups are currently taken. While I've had no issues so far, double check your outputs and
probably backup `~/.config` before running.

> [!WARNING]
> When I delete a neovim plugin, you will need to `rm -rf ~/.config/nvim` and run `just update`
again.

Uninstall using `just uninstall` (untested).

### Submodules
As described below, the terminal background catboy artworks are kept as a private submodule in
`config/dotfiles-artwork` for copyright reasons.

The `rcm` tool is able to handle host-specific dotfiles as well. Because some of these contain sensitive
system information, they are also kept in a private submodule as `host-serpent` (workstation) or `host-gecko`
(laptop). These point to the same `dotfiles-hostspecific` repo, but on different branches.
You should also probably edit these directly as a submodule, making sure to checkout master.

Bump submodules with `just update` or `just updatepush`.

> Neovim config also used to be a submodule, but I merged it in here instead.

## Note on art
The cute catboys I use as terminal backgrounds are drawn by talented artists on DeviantArt or Pixiv. Based on
DeviantArt's [copyright policy](https://www.deviantart.com/about/policy/copyright/), it would be copyright
infringement for be to upload them to this repo, especially since I had to edit some to make them have a dark
theme. Plus, even if you put copyright aside, the artists may not want my god-awful edits uploaded here and I
totally respect that.

Instead, currently these artworks are kept in a separate, private repo for personal use only, which to my
understanding should fall under fair use (I'm not and would never be a lawyer, ick).

However, the artwork I used is linked below, so you can recreate it yourself if you'd like.

Current base dark background: https://unsplash.com/photos/black-grey-and-blue-painting-1JLIC7bnoZA

> used when necessary to attach non-rectangular character portraits to, basically to pad out the editor with a
> background so it's not all white. I usually attach the portrait on the right hand side of the screen.

My current catboy: https://www.deviantart.com/ruruko01/art/c-squid-plushie-976595432

> isn't he just the cutest :pleading: with his squid :pleading: :pleading:

## References
- https://thoughtbot.com/upcase/videos/manage-and-share-your-dotfiles-with-rcm

## Licence
WTFPL 2.0

_except any files marked otherwise_

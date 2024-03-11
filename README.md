# Dotfiles
dotfiles lfg!!!!!!!!!!!!!!

## How to use
### Prerequisites
First, clone into `~/.dotfiles`: 

```
git clone --recurse-submodules -j8 git@github.com:mattyoung101/dotfiles.git ~/.dotfiles
```

The dotfiles are managed using [rcm](https://github.com/thoughtbot/rcm) and
[Just](https://github.com/casey/just), which you can install using something like `yay -S rcm just`.

### Installing
First, confirm what would be installed using `just show`.

Install using `just install`. 

> **Warning:** No backups are currently taken. While I've had no issues so far, double check your outputs and
> probably backup `~/.config` before running.

Uninstall using `just uninstall`.

### Submodules
My neovim config is kept as a submodule in `config/nvim`. It's recommended to edit this _as a submodule_
inside _this repo_ rather than edit that repo directly. **Important:** You should make note to checkout the
master branch before editing, otherwise you'll be in a detached head state.

As described below, the terminal background catboy artworks are kept as a private submodule in
`config/dotfiles-artwork` for copyright reasons.

The `rcm` tool is able to handle host-specific dotfiles as well. Because some of these contain sensitive
system information, they are also kept in a private submodule as `host-serpent` (workstation) or `host-gecko`
(laptop). These point to the same `dotfiles-hostspecific` repo, but on different branches.
You should also probably edit these directly as a submodule, making sure to checkout master.

There is a GitHub Action in my [nvim-setup](https://github.com/mattyoung101/nvim-setup) repo that will
automatically update the `nvim` submodule whenever I push to it.

Bump submodules with `just update`.

FIXME: we may not need this action actually, we could make a post commit hook to update the submodules? or a
FIXME just action?

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


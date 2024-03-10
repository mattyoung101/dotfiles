# Dotfiles
dotfiles lfg!!!!!!!!!!!!!!

## How to use
### Prerequisites
First, clone into `~/.dotfiles`: 

```
git clone --recurse-submodules git@github.com:mattyoung101/dotfiles.git ~/.dotfiles
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
There is a GitHub Action setup in my [nvim-setup](https://github.com/mattyoung101/nvim-setup) repo that will
automatically update the `nvim` submodule whenever I push to it.

To bump submodules with `git submodule update --init --recursive` (although this should be handled by the GH
action automatically).

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


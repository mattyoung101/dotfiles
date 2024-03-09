# Dotfiles
dotfiles lfg!!!!!!!!!!!!!!

The install script is from @henrybatt's dotfiles: https://github.com/henrybatt/dotfiles

## How to use
Clone with `git clone --recurse-submodules`

Bump submodules with `git submodule update --init --recursive`

Install dotfiles using `./install -v`

## Note on patches
Most of my dotfiles are relatively similar across systems, with some minor differences. To fix this, I'm going
to write a system that takes the _base_ dotfiles and applies a set of public and private git patches to them
when they are being installed. The patches to apply will automatically be decided based on the machine's 
`hostname`.

Public patches are those which can be made publicly available. For example, a patch to
`~/.config/borgmatic/config.yaml` (the backup system I use) that changes the backup path depending on
laptop/PC.

Private patches are those which cannot be made publicly available for various reasons, usually related to
work. These are kept in a separate, private submodule. My current example is a patch to
`~/.config/fish/config.fish` that sources some proprietary/confidential software from my employer.

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

## TODOs
- Implement patching system
- Add a GitHub actions pipeline in either this or nvim-config that automatically bumps the nvim subrepo
whenever it's pushed

## Licence
My dotfiles: WTFPL 2.0

Henry's install script: MIT licence


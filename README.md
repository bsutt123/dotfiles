# Getting new machine up to speed

This is meant to be a personal documentation about how I get my machine setup
using these dotfiles

## Install Chrome and LastPass

Obvious, install Chrome and LastPass for all of your passwords

## Install xcode-select

run this to get xcode install

```bash
$ xcode-select --install
```

this gives you git and a couple other command line tools. If possible avoid full
xcode like the plaugue, it brings a sadness to this household and is not
welcome.

## Download dotfiles locally

clone this repo locally wherever you like, perferably in an accesible location
because you will be doing some symlinking

## Install brew

Just do it

## Install nvim

You might need to install the nightly version, as of the writing of this the
version in brew does not have the ability to do floating boxes in coc which is
pretty cool. Installing nightly version is pretty easy, just search for latest,
unpack it and then make an alias for nvim to the bin file to run nvim

you need to also symbolic link vimrc to `init.vim` in the config directory.

## Install Karabineer elements

You are basically useless without the advanced command to turn capslock into ESC
or CTRL based on what is typed. Just install it and then symlink the dotfiles
one to the config directory (by default `.config/karabiner`)

## 


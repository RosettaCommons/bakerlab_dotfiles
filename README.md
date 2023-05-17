Dotfiles
========
Configuration files the way we like 'em!
The included setup script creates symlinks from your home directory to the files which are located in `~/dotfiles`.

The install script will:

1. Back up any existing dotfiles in your home directory to `~/dotfiles_old`
2. Create symlinks to the dotfiles in `dotfiles` in your home directory

I (@weitzner) prefer `zsh` as my shell; the script assumes `zsh` is set as the default shell and that the `oh-my-zsh` add-on is being used.
This means that I have a `zshrc` file as well as a custom `zsh-theme` file that both need to be moved into place.

Installation
------------
``` bash
git clone git://github.com/weitzner/dotfiles ~/dotfiles
cd ~/dotfiles
sh symlink_dotfiles.sh
```

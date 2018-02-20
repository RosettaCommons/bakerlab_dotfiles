#!/bin/bash

# This script creates symlinks from the home directory to the analogous
# file in the repository

# This script assumes it's being run in the Dotfiles directory
# Example usage:
# cd ~/Dotfiles && sh symlink_dotfiles.sh

dir=`pwd`/home_dir                 # dotfiles directory
old_dir=$HOME/dotfiles_old         # backup directory for old dotfiles
pymol_scripts_dir=`pwd`/pymol_scripts # absolute path to pymol_scripts

zsh_theme=verbose.zsh-theme        # zsh theme file
zsh_dir=$HOME/.oh-my-zsh/custom    # oh my zsh installation directory

# Move extant dotfiles to $old_dir, then create symlinks
# This function takes three arguments:
## 1. The full path of the final symlink
## 2. The full path of the dotfile in the repository
## 3. The name of the dotfile
link_dotfile ()
{
    if [[ -f $1 ]]; then
        echo "Moving existing dotfile ($1) to $old_dir"
        mv $1 $old_dir/$3
    fi
    echo "Creating symlink to $1 in home directory.\n"
    ln -s $2 $1
}

# Create a directory ($old_dir) to hold the old version of the config files
if [[ ! -e $old_dir ]]; then
    echo "Creating $old_dir for backup of any existing dotfiles in ~"
    mkdir -p $old_dir
    echo "...done"
fi

# Symlink all of the files in "home_dir"
for dotfile in `ls $dir`; do
    link_dotfile $HOME/.$dotfile $dir/$dotfile $dotfile
done

link_dotfile $HOME/pymol_scripts $pymol_scripts_dir

# Symlink the zsh theme (only if oh my zsh is installed)
if [[ -e $zsh_dir ]]; then
    link_dotfile $zsh_dir/$zsh_theme `pwd`/$zsh_theme $zsh_theme
fi

# Check for the presence of a GPG key and set it to sign git commits
# NOTE: this will modify the linked gitconfig file the changes need not be
# committed. If they are and the file is pushed to a system without a GPG key,
# the attempts to sign commits will fail. If the changes are committed to a
# system with a GPG key, the configuration will be overwritten with the key on
# that system and function properly.
KEY_ID=`gpg --list-secret-keys --keyid-format LONG | awk '{if ($1 == "sec"){split($2, l, "/"); printf "%s", l[2]}}'`
if [[ ${#KEY_ID} -gt 0 ]]; then
    echo "Adding GPG key to the global git configuration"
    git config --global user.signingkey $KEY_ID
    git config --global commit.gpgsign true
fi

git config --global core.excludesfile $HOME/.gitignore_global
echo "Test out your configurations and, if it all looks good, delete" $old_dir

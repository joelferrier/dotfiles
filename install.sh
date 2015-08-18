#!/bin/bash
# dotfiles installation script
# https://github.com/joelferrier/dotfiles



# ln -s /path/to/file /path/to/symlink

# bash configuration

if [ ! -f ~/.bash_profile.old ]; then
    mv ~/.bash_profile ~/.bash_profile.old;
    cp ~/.dotfiles/bash_profile ~/.bash_profile;
    cp ~/.dotfiles/bash_prompt ~/.bash_prompt;
    echo ". ~/.bash_profile" >> ~/.bashrc;
fi

# i3 window manager config

if [ ! -f ~/.i3/config ]; then
    cp ~/.dotfiles/background.jpg ~/fehbg;
    mkdir ~/.i3;
    cp ~/.dotfiles/i3config ~/.i3/config
    cp ~/.dotfiles/i3status.conf ~/.i3status.conf
fi


###################################
# vim configuration
###################################

# ensure the .vim directory exists
if [ ! -d ~/.vim ]; then
    mkdir ~/.vim;
    touch ~/.vim/packages.vim;
    touch ~/.vim/shortcuts.vim;
fi

# download Vundle files
if [ ! -d ~/.vim/bundle ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim;
fi
# copy preconfigured vimrc
if [ ! -f ~/.vimrc ]; then
    cp ~/.dotfiles/vimrc ~/.vimrc;
    vim +PluginInstall +qall;
    echo "colorscheme solarized" >> ~/.vimrc;
fi


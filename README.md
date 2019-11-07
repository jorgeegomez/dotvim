# Vim Configuration

Vim configuration using **vim-plug**

## Introduction

Personal config file for vim, including the use of **vimwiki** for blogging
and log of daily activities.

## Installation

1. `cd`
1. `git clone https://github.com/jorgeegomez/dotvim ~/.vim`
1. `mv ~/.vimrc{,.backup}`
1. `ln -s .vim/vimrc .vimrc`
1. `cd .vim`
1. `mkdir {backup,swap}`
1. `curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`
1. `vim +PlugInstall +qall`
1. `echo "alias vw='vim -c VimwikiIndex'" >> ~/.bash_aliases`

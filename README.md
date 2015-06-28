# Vim Configuration

Vim configuration using Pathogen and git submodules

## Introduction

Personal config file for vim, including the use of **vimwiki** for blogging
and log of daily activities.

## Installation

1. `cd`
1. `git clone https://github.com/jorgeegomez/dotvim ~/.vim`
1. `cd .vim`
1. `git submodule init && git submodule update`
1. `cd`
1. `mv ~/.vimrc ~/.vimrc.backup`
1. `ln -s .vim/vimrc .vimrc`
1. `echo "alias vw='vim -c VimwikiIndex'" >> .bash_aliases`

## Plugins and usage

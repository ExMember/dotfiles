dotfiles
========

Custom configuration files.

# vi

## Setup

1. Delete or move the local vim config:  
  `rm ~/.vimrc` or  
  `mv ~/.vimrc ~/.vimrc.local`

2. Link to the new vim config file:  
  `ln -s <PATH_TO_REPO>/dotfiles/vimrc ~/.vimrc`

3. Get [Vundle](https://github.com/gmarik/Vundle.vim):  
  `git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim`  
  `vim +PluginInstall +qall`

# git

## Setup

1. Install [Exuberant Ctags](http://ctags.sourceforge.net/):  
  OS X: `brew install ctags`  
  The output from `ctags --version` should say "Exuberant CTags"  

2. Use the template directory for all new git repos:
  `git config --global init.templatedir '<PATH_TO_REPO>/git_template'`

3. Add the template files to pre-existing repos:
  `git init`

## Features

Update the ctags file whenever the repository changes. (Stolen from [Tim
Pope](http://tbaggery.com/2011/08/08/effortless-ctags-with-git.html))

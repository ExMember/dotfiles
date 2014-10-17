dotfiles
========

Custom configuration files.

## Vi

1. Delete or move the local vim config:
  `rm ~/.vimrc` or
  `mv ~/.vimrc ~/.vimrc.local`

2. Link to the new vim config file:
  `ln -s <PATH_TO_REPO>/dotfiles/vimrc ~/.vimrc`

3. Get [Vundle](https://github.com/gmarik/Vundle.vim):
  `git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
  `vim +PluginInstall +qall`


This is my vim environment for development on linux. It is nothing fancy,
just a collection of plugins and settings I like.

**How to use**

In your home dir:

` $ git clone https://github.com/kjyv/dotvim-linux.git .vim `

` $ mv .vimrc .vimrc_old && ln -s .vim/vimrc .vimrc `

` $ mv .gvimrc .gvimrc_old && ln -s .vim/gvimrc .gvimrc `

` $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`

` $ vim +PluginInstall +qall`

Then make sure you have installed the jedi python module, either with pip or with your system package manager (e.g. python-jedi).
For vim-airline it is also necessary to install patched fonts, please refer to the [powerline documentation](https://powerline.readthedocs.org/en/master/installation.html#patched-fonts).

This is my vim environment for development on linux.
It is a collection of plugins and settings I like.
It should be compatible with vim >7.4 and nvim.

**How to use**

In your home dir:

` $ git clone https://github.com/kjyv/dotvim-linux.git .vim `

` $ mv .vimrc .vimrc_old && mv .gvimrc .gvimrc_old `

` $ vim `

This should install plugins when running for the first time.

Then make sure you have installed the jedi python module, either with pip or with your system package manager (e.g. python-jedi).
For vim-airline it is also necessary to install patched fonts, please refer to the [powerline documentation](https://powerline.readthedocs.org/en/master/installation.html#patched-fonts).
For ale linting, you should install whichever linter you need, e.g. pylint.

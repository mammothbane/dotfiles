# -*- mode: shell-script -*-

# oh-my-zsh config
if [ -d $HOME/.oh-my-zsh ]; then
    # Path to your oh-my-zsh installation.
    export ZSH="$HOME/.oh-my-zsh"

    # Set name of the theme to load.
    # Look in ~/.oh-my-zsh/themes/
    # Optionally, if you set this to "random", it'll load a random theme each
    # time that oh-my-zsh is loaded.
    ZSH_THEME="robbyrussell"

    plugins=(git rails golang github)

    . $ZSH/oh-my-zsh.sh
fi
    
# User configuration
if [ -f ~/.rc ]; then
    . ~/.rc
fi

if [ -f ~/.local_zshrc ]; then
    . ~/.local_zshrc
fi


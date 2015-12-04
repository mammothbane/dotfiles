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

export PATH="$HOME/src/appengine_go:$HOME/src/appengine_py:$HOME/bin:$HOME/src/go/bin:$HOME/src/google-cloud-sdk/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/jvm/java-8-oracle/bin:/usr/lib/jvm/java-8-oracle/db/bin:/usr/lib/jvm/java-8-oracle/jre/bin:$HOME/.rvm/bin:$HOME/.rvm/bin"
export GOPATH=$HOME/src/go

export EDITOR="emacs -nw"
export VISUAL="emacs"

export GIT_TEMPLATE_DIR=$HOME/.git_template

# overwrite versioned config with local
if [ -f ~/.local_aliases ]; then
    . ~/.local_aliases
fi

if [ -f ~/.local_zshrc ]; then
    . ~/.local_zshrc
fi


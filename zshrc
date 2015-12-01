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

    # Uncomment the following line to use case-sensitive completion.
    # CASE_SENSITIVE="true"

    # Uncomment the following line to use hyphen-insensitive completion. Case
    # sensitive completion must be off. _ and - will be interchangeable.
    # HYPHEN_INSENSITIVE="true"

    # Uncomment the following line to disable bi-weekly auto-update checks.
    # DISABLE_AUTO_UPDATE="true"

    # Uncomment the following line to change how often to auto-update (in days).
    # export UPDATE_ZSH_DAYS=13

    # Uncomment the following line to disable colors in ls.
    # DISABLE_LS_COLORS="true"

    # Uncomment the following line to disable auto-setting terminal title.
    # DISABLE_AUTO_TITLE="true"

    # Uncomment the following line to enable command auto-correction.
    # ENABLE_CORRECTION="true"

    # Uncomment the following line to display red dots whilst waiting for completion.
    # COMPLETION_WAITING_DOTS="true"

    # Uncomment the following line if you want to disable marking untracked files
    # under VCS as dirty. This makes repository status check for large repositories
    # much, much faster.
    # DISABLE_UNTRACKED_FILES_DIRTY="true"

    # Uncomment the following line if you want to change the command execution time
    # stamp shown in the history command output.
    # The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
    # HIST_STAMPS="mm/dd/yyyy"

    # Would you like to use another custom folder than $ZSH/custom?
    # ZSH_CUSTOM=/path/to/new-custom-folder

    plugins=(git rails golang github)

    . $ZSH/oh-my-zsh.sh
fi
    
    
# User configuration

export PATH="$HOME/src/appengine_go:$HOME/src/appengine_py:$HOME/bin:$HOME/src/go/bin:$HOME/src/google-cloud-sdk/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/jvm/java-8-oracle/bin:/usr/lib/jvm/java-8-oracle/db/bin:/usr/lib/jvm/java-8-oracle/jre/bin:$HOME/.rvm/bin:$HOME/.rvm/bin"
export GOPATH=$HOME/src/go

export EDITOR="emacs -nw"
export VISUAL="emacs"

export GIT_TEMPLATE_DIR=$HOME/.git_template


# aliases

alias da=dev_appserver.py
alias xemacs="/usr/bin/emacs"
alias emacs="/usr/bin/emacs -nw"
alias sl="sl -e"
alias git=hub
alias xclip="xclip -selection c"
alias logvew="less +F"
alias lv="less +F"

# overwrite versioned config with local
if [ -f ~/.local_aliases ]; then
    . ~/.local_aliases
fi

if [ -f ~/.local_zshrc ]; then
    . ~/.local_zshrc
fi


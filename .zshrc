# Executable file path
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
export PATH

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="pmcgee"

# Set to this to use case-sensitive completion
export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git rvm gem bundler)

source $ZSH/oh-my-zsh.sh
unsetopt correct_all

# unalias g=git 'cause that is my gvim wrapper script name
unalias g
compdef -d g

# but still want git argument completion for git
compdef git=git

[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f $HOME/.mongo_funcs.sh ] && source $HOME/.mongo_funcs.sh
[ -s $HOME/.rvm/scripts/rvm ] && source $HOME/.rvm/scripts/rvm

# alt-p and alt-n search history with what was typed so far
bindkey '^[p' history-beginning-search-backward
bindkey '^[n' history-beginning-search-forward

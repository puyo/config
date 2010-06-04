# ~/.bashrc: executed by bash(1) for non-login shells.

if [[ ! -z "$PS1" ]] ; then # if running interactively
    shopt -s histappend # append to history file, don't overwrite
    shopt -s checkwinsize # update LINES and COLUMNS

    # make less more friendly for non-text input files, see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

    # prompt
    case "$TERM" in xterm*|rxvt*|screen) 
        PS1='\[\033[01;32m\]\u@\h \[\033[01;34m\]\w\[\033[00m\]\n$(date +%T) \$ ' ;;
    esac

    # window title "user@host: dir"
    case "$TERM" in xterm*|rxvt*)
        PS1="\[\e]0;\u@\h: \w\a\]$PS1" ;;
    esac

    [ -f ~/.bash_aliases ] && . ~/.bash_aliases

    for file in /etc/bash_completion /opt/local/etc/bash_completion; do
        [ -f $file ] && . $file
    done

    [[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
fi

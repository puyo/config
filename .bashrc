# ~/.bashrc: executed by bash(1) for non-login shells.

# node.js
[ -d $HOME/local/bin ] && PATH=$HOME/local/bin:$PATH

if [[ ! -z "$PS1" ]] ; then # if running interactively
  shopt -s histappend # append to history file, don't overwrite
  shopt -s checkwinsize # update LINES and COLUMNS

  # make less more friendly for non-text input files, see lesspipe(1)
  [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

  # prompt
  case "$TERM" in
    xterm*|rxvt*|screen)
      RED="\[\033[01;31m\]"
      GREEN="\[\033[01;32m\]"
      YELLOW="\[\033[01;33m\]"
      BLUE="\[\033[01;34m\]"
      PINK="\[\033[01;35m\]"
      RESET="\[\033[00m\]"

      GIT_BRANCH="${YELLOW}\`ruby -e \"print %x{git branch 2> /dev/null}.match(/\* (.+)$/).to_a.last\"\`\[\033[37m\] "
      USER_AND_HOST="${GREEN}\u@\h"
      DIR="${BLUE}\w${RESET}"
      DATE='$(date +%T)'
      PS1="${USER_AND_HOST} ${GIT_BRANCH}${DIR}\n${DATE} \$ "
  esac

  # window title "user@host dir"
  case "$TERM" in
    xterm*|rxvt*)
      PS1="\[\e]0;\u@\h \w\a\]$PS1" ;;
  esac

  [ -f ~/.bash_aliases ] && . ~/.bash_aliases

  for file in /etc/bash_completion /opt/local/etc/bash_completion; do
    [ -f $file ] && . $file
  done

  [[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
fi

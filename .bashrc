# ~/.bashrc: executed by bash(1) for non-login shells.

stty -ixon # disable C-s and C-q pause and resume buttons

[ -f $HOME/.mongo_funcs.sh ] && . $HOME/.mongo_funcs.sh

if [[ ! -z "$PS1" ]] ; then # if running interactively
  shopt -s histappend # append to history file, don't overwrite
  shopt -s checkwinsize # update LINES and COLUMNS

  # prompt
  case "$TERM" in
    xterm*|rxvt*|screen*)
      RED="\[\033[01;31m\]"
      GREEN="\[\033[01;32m\]"
      YELLOW="\[\033[01;33m\]"
      BLUE="\[\033[01;34m\]"
      PINK="\[\033[01;35m\]"
      CYAN="\[\033[0;36m\]"
      GRAY="\[\033[01;30m\]"
      RESET="\[\033[00m\]"

      USER_AND_HOST='\u@\h'
      RVM='$([ -f .rvmrc ] && [ $PWD != $HOME ] && echo "" $(~/.rvm/bin/rvm-prompt i v g))'
      GIT='$(/usr/bin/ruby -e '\''print `git branch 2> /dev/null`.match(/\*(.+)$/).to_a.last.to_s'\'')'
      DIR=' \w'
      DATE='$(date +%T)'
      PS1="${GREEN}${USER_AND_HOST}${CYAN}${RVM}${YELLOW}${GIT}${BLUE}${DIR}${RESET}\n${GRAY}${DATE}${RESET} \$ "
      unset USER_AND_HOST RVM GIT DIR DATE
  esac

  # window title "user@host dir"
  case "$TERM" in
    xterm*|rxvt*)
      PS1="\[\e]0;\u@\h \w\a\]$PS1" ;;
  esac

  [ -f ~/.bash_aliases ] && . ~/.bash_aliases

  for dir in /etc/bash_completion /usr/local/etc/bash_completion.d; do
    if [ -d $dir ]; then
      for file in $dir/*; do
        . $file 2> /dev/null
      done
    fi
  done

  # Remember the PWD between prompts
  [ -f $HOME/.bash_sticky ] && source $HOME/.bash_sticky

  # Travis
  [ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh
fi

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$PATH:./node_modules/.bin" # Add node modules bin path

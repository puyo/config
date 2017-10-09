# ~/.bashrc: executed by bash(1) for non-login shells.

# avoid everything in this file, if in --posix mode
shopt -oq posix && return

if [[ ! -z "$PS1" ]] ; then # if running interactively
  shopt -s histappend # append to history file, don't overwrite
  shopt -s checkwinsize # update LINES and COLUMNS
  stty -ixon # disable C-s and C-q pause and resume buttons

  case "$TERM" in
    xterm*|rxvt*|screen*)
      red="\[\033[01;31m\]"
      green="\[\033[01;32m\]"
      yellow="\[\033[01;33m\]"
      blue="\[\033[01;34m\]"
      pink="\[\033[01;35m\]"
      cyan="\[\033[0;36m\]"
      gray="\[\033[01;30m\]"
      reset="\[\033[00m\]"

      user_and_host='\u@\h'
      rvm='$([ -f .rvmrc ] && [ $PWD != $HOME ] && echo "" $(~/.rvm/bin/rvm-prompt i v g))'
      git='$(/usr/bin/ruby -e '\''print `git branch 2> /dev/null`.match(/\*(.+)$/).to_a.last.to_s'\'')'
      dir=' \w'
      date='$(date +%T)'
      PS1="${green}${user_and_host}${cyan}${rvm}${yellow}${git}${blue}${dir}${reset}\n${gray}${date}${reset} \$ "
      unset user_and_host rvm git dir date

      # window title "user@host dir"
      PS1="\[\e]0;\u@\h \w\a\]$PS1"
    ;;
  esac

  for file in /etc/bash_completion /usr/local/etc/bash_completion; do
    [ -f "$file" ] && source "$file"
  done

  user_sources=(.bash_aliases .bash_sticky)

  for file in "${user_sources[@]}"; do
    [ -f "$HOME/$file" ] && source "$HOME/$file"
  done
fi

# ~/.bashrc: executed by bash(1) for non-login shells.

# avoid everything in this file, if in --posix mode
shopt -oq posix && return

if [[ ! -z "$PS1" ]] ; then # if running interactively
  shopt -s histappend # append to history file, don't overwrite
  shopt -s checkwinsize # update LINES and COLUMNS
  stty -ixon # disable C-s and C-q pause and resume buttons

  case "$TERM" in
    xterm*|rxvt*|screen*)
      _set_prompt() {
        local red="\[\033[01;31m\]"
        local green="\[\033[01;32m\]"
        local yellow="\[\033[01;33m\]"
        local blue="\[\033[01;34m\]"
        local pink="\[\033[01;35m\]"
        local cyan="\[\033[0;36m\]"
        local gray="\[\033[01;30m\]"
        local reset="\[\033[00m\]"

        local user_and_host='\u@\h'
        #local rvm='$([ -f .ruby-version ] && [ $PWD != $HOME ] && echo "" $(~/.rvm/bin/rvm-prompt i v g))'

        local ruby='$(if [ ! -z "$RUBY_VERSION" ]; then echo -n " ruby $RUBY_VERSION"; fi)'
        local git='$(__git_ps1 | sed "s/[()]//g" 2>/dev/null)'

        #local ruby='$(if [ ! -z "$RUBY_VERSION" ]; then echo -n " $RUBY_VERSION"; fi)'
        #local git='$(/usr/bin/ruby -e '\''print `git branch 2> /dev/null`.match(/\*(.+)$/).to_a.last.to_s'\'')'

        local dir=' \w'
        local date='$(date +%T)'
        PS1="${green}${user_and_host}${cyan}${ruby}${yellow}${git}${blue}${dir}${reset}\n${gray}${date}${reset} \$ "

        # add window title "user@host dir"
        PS1="\[\e]0;\u@\h \w\a\]$PS1"
      }
      _set_prompt
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

if [ -d "$HOME/.asdf" ]; then
  source $HOME/.asdf/asdf.sh
  source $HOME/.asdf/completions/asdf.bash
fi

# export PATH=$PATH:/Users/greg/Blake/bs/bin/

# ~/.bashrc: executed by bash(1) for non-login shells.

# avoid everything in this file, if in --posix mode
shopt -oq posix && return

if [[ ! -z "$PS1" ]] ; then # if running interactively
  shopt -s histappend            # append to history file, don't overwrite
  shopt -s checkwinsize          # update LINES and COLUMNS
  shopt -s globstar 2> /dev/null # allow ** file patterns on Bash 4+
  stty -ixon                     # disable C-s and C-q pause and resume buttons

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

        __which_tool() {
          p=$PWD
          tool=$1

          while [ ! -z "${p}" ]; do
            path="${p}/.tool-versions"
            if [ -f "${path}" ]; then
              result=`grep $tool "${path}"`
              if [ ! -z "${result}" ]; then
                echo $result
                return 0
              fi
            fi
            path="${p}/.ruby-version"
            if [ -f "${path}" ]; then
              cat "${path}"
              return 0
            fi
            p=${p%/*}
          done
        }

        __ruby_prompt() {
          local ruby=$(__which_tool ruby | sed -E 's/^ruby ([[:digit:]\.]+)(.*)$/\1/')
          case $(which ruby) in
            *asdf/shims/ruby)
              ruby=" ruby-${ruby} (asdf)"
              ;;
            *.rubies*)
              ruby=" ruby-${ruby} (chruby)"
              ;;
            *)
              ruby=" ruby-${ruby} (os)"
              ;;
          esac
          echo $ruby
        }
        local git='$(__git_ps1 " %s")'
        local dir=' \w'
        local date='$(date +%T)'
        PS1="${green}${user_and_host}${cyan} \$(__ruby_prompt)${yellow}${git}${blue}${dir}${reset}\n${gray}${date}${reset} \$ "

        # add window title "user@host dir"
        PS1="\[\e]0;\u@\h \w\a\]$PS1"
      }
      _set_prompt
      unset _set_prompt
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

export GOPATH=$HOME/go
PATH=$PATH:${GOPATH//://bin:}/bin

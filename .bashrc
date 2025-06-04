# ~/.bashrc: executed by bash(1) for non-login shells.

# avoid everything in this file, if in --posix mode
shopt -oq posix && return

if [[ ! -z "$PS1" ]] ; then # if running interactively
  shopt -s histappend            # append to history file, don't overwrite
  shopt -s checkwinsize          # update LINES and COLUMNS
  shopt -s globstar 2> /dev/null # allow ** file patterns on Bash 4+
  stty -ixon                     # disable C-s and C-q pause and resume buttons

  # --------------------------------------------------
  # mise (Elixir, Ruby, Erlang, Node)
  #
  # Setup:
  #
  #   curl https://mise.run | sh
  #   bash -l # or restart
  #   mise use -g usage

  if [ -x "$HOME/.local/bin/mise" ]; then
    PATH="${PATH}:${HOME}/.local/bin"
  fi

  if command -v mise > /dev/null; then
    eval "$(mise activate bash)"
  fi

  case "$TERM" in
    xterm*|rxvt*|screen*)
      _set_prompt() {
        local red="\[\033[01;31m\]"
        local bgreen="\[\033[01;32m\]"
        local green="\[\033[0;32m\]"
        local yellow="\[\033[01;33m\]"
        local blue="\[\033[01;34m\]"
        local pink="\[\033[01;35m\]"
        local cyan="\[\033[0;36m\]"
        local gray="\[\033[01;30m\]"
        local pinkbg="\[\033[0;45m\]"
        local reset="\[\033[00m\]"
        local user_and_host='\u@\h'

        __mise_prompt() {
          local tool=$1
          local only_if_file=$2
          if [ ! -z "${only_if_file}" ]; then
            [ "$(git ls-files ${only_if_file} 2> /dev/null)" == "${only_if_file}" ] || return
          fi
          local v=$(mise tool "${tool}" --active)
          if [ "${v}" != "[none]" ]; then
            echo " ${tool}-${v}"
          fi
        }
        
        PROMPT_COMMAND="__exit_status=\$?" # save for use anywhere in PS1

        PS1="" # reset
        PS1="${PS1}${bgreen}${user_and_host}"    # user/host
        PS1="${PS1}${gray} \$(date +%T)"         # timestamp
        PS1="${PS1} \`[ \$__exit_status == 0 ] && echo '${green}■' || echo '${red}■'\`" # exit status
        PS1="${PS1}${cyan}\$(__mise_prompt ruby Gemfile)"
        PS1="${PS1}${cyan}\$(__mise_prompt node package.json)"
        PS1="${PS1}${yellow}\$(__git_ps1 ' %s')" # git info
        PS1="${PS1}${blue} \w"                   # directory
        PS1="${PS1}${reset}\n \$ "               # prompt
        PS1="\[\e]0;\u@\h \w\a\]${PS1}"          # add window title "user@host dir"
      }
      _set_prompt
      unset _set_prompt
    ;;
  esac

  completion_files=(
    /etc/bash_completion
    /usr/local/etc/bash_completion
    /usr/local/etc/bash_completion.d/git-prompt.sh
    ~/.helm_bash_completion
    ~/.npm_completion
    ~/.kube_completion
    ~/.mix_completion.bash
    ~/.mise_completion.bash
  )

  for file in "${completion_files[@]}"; do
    [ -f "$file" ] && source "$file"
  done

  source <("$HOME/.local/bin/mise" completion bash --include-bash-completion-lib)

  user_sources=(.bash_aliases .bash_sticky)

  for file in "${user_sources[@]}"; do
    [ -f "$HOME/$file" ] && source "$HOME/$file"
  done

  unset completion_files user_sources

  export GOPATH=$HOME/go
  PATH=$PATH:${GOPATH//://bin:}/bin

  export ADBPATH=$HOME/android/platform-tools/
  PATH=$PATH:${ADBPATH}
fi

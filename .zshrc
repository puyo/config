# Executable file path
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
export PATH

# Set to this to use case-sensitive completion
export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# alt-p and alt-n search history with what was typed so far
bindkey '^[p' history-beginning-search-backward
bindkey '^[n' history-beginning-search-forward

if [[ ! -z "$PROMPT" ]] ; then # if running interactively

  stty -ixon # disable C-s and C-q pause and resume buttons
  setopt promptsubst

  case "$TERM" in
    xterm*|rxvt*|screen*)
      # red="\[\033[01;31m\]"
      # green="\[\033[01;32m\]"
      # yellow="\[\033[01;33m\]"
      # blue="\[\033[01;34m\]"
      # pink="\[\033[01;35m\]"
      # cyan="\[\033[0;36m\]"
      # gray="\[\033[01;30m\]"
      # reset="\[\033[00m\]"

      user_and_host='%n@%m'
      git='$(/usr/bin/ruby -e '\''print `git branch 2> /dev/null`.match(/\*(.+)$/).to_a.last.to_s'\'')'
      dir='%~'
      date='%*'
      newline=$'\n'

      PROMPT="%F{118}${user_and_host}%F{yellow}${git}%F{blue} ${dir}${reset_color}${newline}%F{238}${date}%f \$ "
      unset user_and_host rvm git dir date
    ;;
  esac

  autoload -Uz compinit && compinit

  # user_sources=(.bash_aliases)

  # for file in "${user_sources[@]}"; do
  #   [ -f "$HOME/$file" ] && source "$HOME/$file"
  # done
fi

source $HOME/.asdf/asdf.sh

export GOPATH=$HOME/go
PATH=$PATH:${GOPATH//://bin:}/bin

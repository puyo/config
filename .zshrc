# executable file path
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
export PATH

# set to this to use case-sensitive completion
export CASE_SENSITIVE="true"

if [[ ! -z "$PROMPT" ]] ; then # if running interactively
  autoload -Uz compinit && compinit # zsh completion
  autoload -Uz bashcompinit && bashcompinit # bash completion command support

  # asdf
  source $HOME/.asdf/completions/asdf.bash

  # set history file
  export HISTFILE="$HOME/.zhistory"
  export SAVEHIST=10000

  # alt-backspace deletes the whole path! gah! fix it!
  export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'  ;# without /

  # tab completion directory names prints a slash and then deletes it sometimes! gah! fix it!
  setopt no_auto_remove_slash

  # alt-p and alt-n search history with what was typed so far
  bindkey '^[p' history-beginning-search-backward
  bindkey '^[n' history-beginning-search-forward

  # disable C-s and C-q pause and resume buttons
  stty -ixon

  # allow $(...) commands inside the prompt
  setopt promptsubst

  case "$TERM" in
    xterm*|rxvt*|screen*)
      [ -f /usr/local/etc/bash_completion.d/git-prompt.sh ] && source /usr/local/etc/bash_completion.d/git-prompt.sh

      local user_and_host='%n@%m'
      local git='$(__git_ps1 " %s")'
      local dir='%~'
      local date='%*'
      local newline=$'\n'

      __ruby_prompt() {
        ruby=" ruby-$(ruby --version | sed -E 's/^ruby ([[:digit:]\.]+)(.*)$/\1/')"
        echo $ruby
      }

      PROMPT="%B%F{118}${user_and_host}%F{cyan}\$(__ruby_prompt)%B%F{yellow}${git}%F{blue} ${dir}${reset_color}${newline}%F{#999}${date}%f%b \$ "
    ;;
  esac

  # go
  export GOPATH=$HOME/go
  PATH=$PATH:${GOPATH//://bin:}/bin

  # aliases
  source $HOME/.zsh_aliases
fi

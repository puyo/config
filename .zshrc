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

# Set history file
export HISTFILE="$HOME/.zhistory"
export SAVEHIST=10000

# alt-p and alt-n search history with what was typed so far
bindkey '^[p' history-beginning-search-backward
bindkey '^[n' history-beginning-search-forward

source /usr/local/etc/bash_completion.d/git-prompt.sh

if [[ ! -z "$PROMPT" ]] ; then # if running interactively

  stty -ixon # disable C-s and C-q pause and resume buttons
  setopt promptsubst

  case "$TERM" in
    xterm*|rxvt*|screen*)
      local user_and_host='%n@%m'
      local git='$(__git_ps1 " %s")'
      local dir='%~'
      local date='%*'
      local newline=$'\n'

      __ruby_prompt() {
        ruby="$(ruby --version | sed -E 's/^ruby ([[:digit:]\.]+)(.*)$/\1/')"
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

      PROMPT="%F{118}${user_and_host}%F{cyan}\${__ruby_prompt}%F{yellow}${git}%F{blue} ${dir}${reset_color}${newline}%F{238}${date}%f \$ "
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

autoload -Uz bashcompinit

bashcompinit

source $HOME/.asdf/completions/asdf.bash

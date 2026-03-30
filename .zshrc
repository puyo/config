# executable file path
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
export PATH

# set to this to use case-sensitive completion
export CASE_SENSITIVE="true"

if [[ ! -z "$PROMPT" ]] ; then # if running interactively
  # fpath must be set before compinit
  [ -d /usr/local/share/zsh-completions ] && fpath=(/usr/local/share/zsh-completions $fpath)
  [ -d ~/.zsh/completions ] && fpath=(~/.zsh/completions $fpath)
  [ -f "$HOME/f/zshrc.sh" ] && source "$HOME/f/zshrc.sh"

  # completions
  autoload -Uz compinit && compinit # zsh completion
  autoload -Uz bashcompinit && bashcompinit # bash completion command support

  # ignore commands on the CLI that start with #, rather than complaining about them
  set -k

  # mise — must be before direnv since direnv is installed via mise
  command -v mise &>/dev/null && eval "$(mise activate zsh)"

  # direnv hook must run in .zshrc (not .zprofile) as it hooks into precmd
  command -v direnv &>/dev/null && eval "$(direnv hook zsh)"

  # history config
  export HISTFILE="$HOME/.zhistory"
  export HISTSIZE=99999
  export HISTFILESIZE=999999
  export SAVEHIST=$HISTSIZE
  setopt BANG_HIST                 # Treat the '!' character specially during expansion.
  setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
  setopt SHARE_HISTORY             # Share history between all sessions.
  setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
  setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
  setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
  setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
  setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
  setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
  setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
  setopt HIST_BEEP                 # Beep when accessing nonexistent history.

  # tab completion settings
  setopt AUTOLIST NO_MENUCOMPLETE

  # alt-backspace deletes the whole path! gah! fix it!
  export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'  ;# without /

  # tab completion directory names prints a slash and then deletes it sometimes! gah! fix it!
  setopt no_auto_remove_slash

  # alt-p and alt-n search history with what was typed so far
  bindkey '^[p' history-beginning-search-backward
  bindkey '^[n' history-beginning-search-forward

  # ctrl-alt-e expands like it does in bash
  bindkey '^[^E' expand-or-complete

  # disable C-s and C-q pause and resume buttons
  stty -ixon

  # allow $(...) commands inside the prompt
  setopt promptsubst

  case "$TERM" in
    xterm*|rxvt*|screen*)
      [ -f "$HOMEBREW_PREFIX/etc/bash_completion.d/git-prompt.sh" ] && source "$HOMEBREW_PREFIX/etc/bash_completion.d/git-prompt.sh"

      local user_and_host='%n@%m'
      local git='$(__git_ps1 " %s")'
      local dir='%~'
      local date='%*'
      local newline=$'\n'

      PROMPT="%B%F{green}${user_and_host}%F{yellow}${git}%F{blue} ${dir}${reset_color}${newline}%F{#999}${date}%f%b \$ "
    ;;
  esac

  # go
  export GOPATH=$HOME/go
  PATH=$PATH:${GOPATH//://bin:}/bin

  # aliases
  source $HOME/.zsh_aliases

  # sticky (last working directory recall on new shell)
  source $HOME/.bash_sticky
fi

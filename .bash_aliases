#!/usr/bin/env bash

source $HOME/.aliases

# ----------------------------------------------------------------------
# Git

# ensure __git_aliased_command is sourced
f=/usr/share/bash-completion/completions/git
[ -f $f ] && source $f

if command -v __git_aliased_command > /dev/null; then
  for alias in `git config --global --name-only --get-regexp alias`; do
    al="${alias/alias./}"
    alias g$al="git $al"
    complete_func=_git_$(__git_aliased_command $al)
    (declare -f -F $complete_func > /dev/null) && __git_complete g$al $complete_func
  done
fi

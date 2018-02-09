#!/bin/sh

# colors
if [ -x /usr/bin/dircolors ]; then
  eval "`dircolors -b`"
  alias ls='ls --color=auto'
  alias dir='ls -lh --color=auto'
else
  # OSX
  alias ls='ls -ohG'
  alias dir='ls -ohG'
fi

function masterbranch() {
  if [[ "$@" != "" ]]; then
    git fetch
    git branch "$@" origin/master
    git checkout "$@"
    git config branch."$@".remote origin
    git config branch."$@".merge refs/heads/"$@"
    git config branch."$@".rebase true
  fi
}

function sprintbranch() {
  if [[ "$@" != "" ]]; then
    git fetch
    git branch "$@" origin/sprint
    git checkout "$@"
    git config branch."$@".remote origin
    git config branch."$@".merge refs/heads/"$@"
    git config branch."$@".rebase true
  fi
}

function developbranch() {
  if [[ "$@" != "" ]]; then
    git fetch
    git branch "$@" origin/develop
    git checkout "$@"
    git config branch."$@".remote origin
    git config branch."$@".merge refs/heads/"$@"
    git config branch."$@".rebase true
  fi
}

# ----------------------------------------------------------------------
# Default arguments for common commands

alias grep='grep --color'
alias less='less -R' # deal with colours
alias make='make -j3' # use more cores

# ----------------------------------------------------------------------
# Rails

function rake { if [ -f './bin/rake' ]; then bundle exec ./bin/rake "$@"; else `which rake` "$@"; fi }
function rails { if [ -f './bin/rails' ]; then bundle exec ./bin/rails "$@"; else `which rails` "$@"; fi }
function rspec { if [ -f './bin/rspec' ]; then bundle exec ./bin/rspec "$@"; else `which rspec` "$@"; fi }

# ----------------------------------------------------------------------
# Git


if type __git_aliases > /dev/null; then
  for al in `__git_aliases`; do
    alias g$al="git $al"
    complete_func=_git_$(__git_aliased_command $al)
    (declare -f -F $complete_fnc > /dev/null) && __git_complete g$al $complete_func
  done
fi

# ----------------------------------------------------------------------
# Allegro 4

function extract_dat {
    datexe="${HOME}/bin/allegro4dat.exe"
    files=`wine ${datexe} "$1" -l | cut -d '-' -f 3 | awk 'NR > 1 { print }'`
    out=`basename -s .dat "${1}"`
    echo $out
    mkdir -p "$out"
    for f in $files; do
        wine "${datexe}" $1 -e "$f" -o "$out/"
    done
}

# ----------------------------------------------------------------------
# Cataclysm DDA

#catasrc=~/Library/Application\ Support/Cataclysm/save/
catasrc=/usr/local/Cellar/cataclysm/*/libexec/save/
catabkp=~/.catabackup/
function catabackup  {
    rsync -rvah ${catasrc} ${catabkp}
}
function catarestore {
    rsync -rvah ${catabkp} ${catasrc}
}

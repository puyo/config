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

alias grep='grep --color'
alias less='less -R' # deal with colours
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gcl='git clone'
alias gcm='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git log'
alias gp='git push'
alias gpu='git pull'
alias gra='git remote add'
alias grr='git remote rm'
alias gs='git status'
alias make="make -j3" # use at least 2 processor cores when building things
alias tail='tail -1000' # at least 1000 lines by default

# Rails spring wrapper helpers so I don't have to care anymore.
function rake { if [ -f './bin/rake' ]; then ./bin/rake "$@"; else `which rake` "$@"; fi }
function rails { if [ -f './bin/rails' ]; then ./bin/rails "$@"; else `which rails` "$@"; fi }
function rspec { if [ -f './bin/rspec' ]; then ./bin/rspec "$@"; else `which rspec` "$@"; fi }

[ -f ~/.bash_smu.sh ] && . ~/.bash_smu.sh

function fixbson() {
  find node_modules -name index.js -type f | \
    grep 'bson/ext/index.js' | \
    xargs ruby -n -i.bak \
    -e 'print $_.gsub("../build/Release/bson", "../browser_build/bson")'
}

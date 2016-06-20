#!/bin/sh

# colors
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='ls -lh --color=auto'
else
    # OSX
    alias ls='ls -G'
    alias dir='ls -ohG'
fi

function masterbranch() {
  if [ "$@" != "" ]; then
    git fetch
    git branch "$@" origin/master
    git checkout "$@"
    git config branch."$@".remote origin
    git config branch."$@".merge refs/heads/"$@"
    git config branch."$@".rebase true
  fi
}

function sprintbranch() {
  if [ "$@" != "" ]; then
    git fetch
    git branch "$@" origin/sprint
    git checkout "$@"
    git config branch."$@".remote origin
    git config branch."$@".merge refs/heads/"$@"
    git config branch."$@".rebase true
  fi
}

function developbranch() {
  if [ "$@" != "" ]; then
    git fetch
    git branch "$@" origin/develop
    git checkout "$@"
    git config branch."$@".remote origin
    git config branch."$@".merge refs/heads/"$@"
    git config branch."$@".rebase true
  fi
}

alias hopla='rake hopla FORCE_INDEX=1'
alias grep='grep --color'
alias less='less -R' # deal with colours
alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gc='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'
alias zr='zeus rspec'
alias mxmlc="$HOME/flex/bin/mxmlc"
alias make="make -j3" # use at least 2 processor cores when building things
alias tail='tail -1000' # at least 1000 lines by default
alias be="bundle exec"
alias hwpr="hub pull-request -b ButenkoT/WDI11_Homework:master"

# Rails spring wrapper helpers so I don't have to care anymore.
function rake { if [ -f './bin/rake' ]; then ./bin/rake "$@"; else `which rake` "$@"; fi }
function rails { if [ -f './bin/rails' ]; then ./bin/rails "$@"; else `which rails` "$@"; fi }
function rspec { if [ -f './bin/rspec' ]; then ./bin/rspec "$@"; else `which rspec` "$@"; fi }

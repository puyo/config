#!/bin/sh

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='ls -lh --color=auto'
else
    # OSX
    alias ls='ls -G'
    alias dir='ls -lhG'
fi

rbgrep() {
    find . -name "*.rb" -print0 | xargs -0 grep --color "$@"
}

railsgrep() {
    find . -name "*.{rb,conf,html,css}" -print0 | xargs -0 grep --color "$@"
}

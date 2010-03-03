#!/bin/sh

# irssi in a screen session on a commonly accessible host
irc() {
    HOST=jube
    while [ 1 ]; do
        ssh -t $HOST screen -dAar
        sleep 10
    done
}

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
    find . -regextype posix-extended \
        -regex ".*(rb|erb|yml|html|css|js)$" \
        -print0 | xargs -0 grep --color "$@"
}

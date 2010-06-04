#!/bin/sh

# colors
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='ls -lh --color=auto'
else
    # OSX
    alias ls='ls -G'
    alias dir='ls -lhG'
fi
alias less='less -R' # deal with colours

alias irc='ssh -t jube screen -dAar'

alias psxiso='pcsx -nogui -runcd -cdfile'
alias psxcd='pcsx -nogui -runcd'
alias danim="dosbox -c 'c:' -c 'cd danim' -exit 'dpa'"

# gvim
[ -x /opt/local/bin/mvim ] && alias gvim='mvim'
alias g='gvim --remote-silent'

rbgrep() {
    find . -name "*.rb" -print0 | xargs -0 grep --color=always "$@"
}

re_find_from_current() {
    if [ `uname` == 'Darwin' ]; then
        find -E . "$@"
    else
        find . -regextype posix-extended "$@"
    fi
}

railsgrep() {
    re_find_from_current -regex ".*(rb|erb|haml|yml|html|css|js|Rakefile|Gemfile)$" \
        -print0 | xargs -0 grep --color=always "$@"
}

svngrep() {
    find . -path "*/.svn" -prune -o -type f -print0 | xargs -0 grep --color=always "$@"
}

alias gs='git status'
alias gcm='git commit -m'

# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.

# Add bin directories to the path.
[ -d $HOME/bin ] && export PATH=$PATH:$HOME/bin
[ -d /usr/kde/3.5/bin ] && export PATH=$PATH:/usr/kde/3.5/bin
[ -d /opt/flex/bin ] && export PATH=$PATH:/opt/flex/bin

alias xlock="gnome-screensaver-command --lock"
alias aterm="urxvt"
alias rtorrent='echo -ne "\033]0;rtorrent\007" && rtorrent'
alias nds=desmume
alias ff=firefox
alias less='less -R'

asgrep(){ find . -name "*.as" | xargs grep -n --colour "$@"; }
rbgrep(){ find . -name "*.rb" | xargs grep -n --colour "$@"; }
pygrep(){ find . -name "*.py" | xargs grep -n --colour "$@"; }
railsgrep(){ 
	find {app,db,script,config,lib,public,test} -name "*.rb" -or -name "*.erb" -or -name "*.rhtml" -or -name "*.html" -or -name "*.js" | xargs grep -n --colour "$@";
}
danim(){ dosbox -forcescaler normal4x -c 'mount b .' "$HOME/bin/deluxepaint/danim/DPA.EXE" -exit; }

export JAVA_HOME=/usr
export EDITOR=/usr/bin/vim
export BROWSER=/usr/bin/firefox
export PAGER="/usr/bin/less -R"
export SVNROOT=https://svn
export DICTIONARY=british
export OOO_FORCE_DESKTOP=gnome
export DEVKITPRO=/opt/devkitpro
export DEVKITARM=$DEVKITPRO/devkitARM

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]]; then
        # Shell is non-interactive.  Be done now
        return
fi

# Make the prompt more colourful.
if ${use_color} ; then
	if [[ ${EUID} != 0 ]] ; then
		PS1='\[\033[01;32m\]\u@\h \[\033[01;34m\]\w\[\033[00m\]\n\[\033[01;30m\]$(date +%T) \[\033[00m\]\$ '
#		PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias dir='ls -lh --color=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

# Change the window title of X terminals 
case $TERM in
        xterm*|rxvt*|Eterm)
                PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.
*}:${PWD/$HOME/~}\007"'
                ;;
        screen)
                PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}
:${PWD/$HOME/~}\033\\"'
                ;;
esac

gemdoc() {
	local gemdir=`gem env gemdir`
	firefox $gemdir/doc/`ls $gemdir/doc/ | grep $1 | sort | tail -1`/rdoc/index.html
}

_gemdocomplete() {
	COMPREPLY=($(compgen -W '$(ls `gem env gemdir`/doc)' -- ${COMP_WORDS[COMP_CWORD]}))
	return 0
}

complete -o default -o nospace -F _gemdocomplete gemdoc

if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

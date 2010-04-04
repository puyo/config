# ~/.profile: executed by the command interpreter for login shells.

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# $PATH
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "/usr/X11/bin" ] && PATH="/usr/X11/bin:$PATH"
[ -d "/opt/local/bin" ] && PATH="/opt/local/bin:$PATH"
[ -d "/opt/local/sbin" ] && PATH="/opt/local/sbin:$PATH"
export PATH

# $BROWSER
if [ -x "/usr/bin/google-chrome" ] ; then
    CHROME="/usr/bin/google-chrome"
else
    CHROME="$HOME/bin/google-chrome"
fi
export BROWSER="$CHROME"

export EDITOR=/usr/bin/vim
export DICTIONARY=british
export PAGER="/usr/bin/less -R"
export OOO_FORCE_DESKTOP=gnome
export LL_BAD_OPENAL_DRIVER=x
export HISTCONTROL=ignoreboth

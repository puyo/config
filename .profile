# ~/.profile: executed by the command interpreter for login shells.

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# $PATH
paths="/opt/local/lib/postgresql84/bin \
    /usr/X11/bin \
    /opt/local/bin \
    /opt/local/sbin \
    $HOME/bin"
for p in $paths; do 
    [ -d $p ] && PATH="$p:$PATH"
done

# $BROWSER
if [ -x "/usr/bin/chromium-browser" ] ; then
  export BROWSER="/usr/bin/chromium-browser"
fi

export EDITOR="/usr/bin/vim"
export DICTIONARY="british"
export PAGER="/usr/bin/less -R"
export OOO_FORCE_DESKTOP="gnome"
export HISTCONTROL="ignoreboth"
export HISTSIZE="100000"
export PATH

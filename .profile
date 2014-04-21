# ~/.profile: executed by the command interpreter for login shells.

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

export ANDROID_HOME="$HOME/Android/sdk"

# $PATH
paths="
    /usr/local/share/npm/bin \
    /usr/local/share/npm/lib/node_modules/coffee-script/bin \
    /usr/X11/bin \
    $HOME/bin \
    $ANDROID_HOME/tools \
    $ANDROID_HOME/platform-tools \
    /usr/local/bin \
    /usr/local/sbin"
for p in $paths; do
    [ -d $p ] && PATH="$p:$PATH"
done

# $BROWSER
if [ -x "/usr/bin/chromium-browser" ] ; then
  export BROWSER="/usr/bin/chromium-browser"
fi

export EDITOR="$HOME/bin/g"
export DICTIONARY="british"
export PAGER="/usr/bin/less -R"
export HISTCONTROL="ignoreboth"
export HISTSIZE="100000"
export PATH

[ -d $HOME/.rvm/bin ] && PATH=$PATH:$HOME/.rvm/bin

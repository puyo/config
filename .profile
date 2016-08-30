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
    /usr/X11/bin \
    $HOME/bin \
    $ANDROID_HOME/tools \
    $ANDROID_HOME/platform-tools \
    /usr/local/bin \
    /usr/local/sbin"
for p in $paths; do
    [ -d $p ] && PATH="$p:$PATH"
done

PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
PATH="$PATH:./node_modules/.bin" # Add node modules bin path

export NVM_DIR="/Users/greg/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

#export EDITOR="$HOME/bin/g"
export DICTIONARY="british"
export PAGER="/usr/bin/less -R"
export HISTCONTROL="ignoreboth"
export HISTSIZE="100000"
export PATH
export ANSIBLE_NOCOWS=1


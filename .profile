# ~/.profile: executed by the command interpreter for login shells.

if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
    # --------------------------------------------------
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
    export PATH

    # if running bash
    if [ -n "$BASH_VERSION" ]; then
        # include .bashrc if it exists
        if [ -f "$HOME/.bashrc" ]; then
            source "$HOME/.bashrc"
        fi
    fi

    # --------------------------------------------------
    # Ruby

    PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
    if [ -d /usr/local/share/chruby ]; then
        source /usr/local/share/chruby/chruby.sh
        source /usr/local/share/chruby/auto.sh
    fi

    # --------------------------------------------------
    # Node

    PATH="$PATH:./node_modules/.bin" # Add node modules bin path
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    export PATH="$PATH:`yarn global bin --offline`" # yarn

    # --------------------------------------------------
    # asdf (Elixir)

    if [ -d "$HOME/.asdf" ]; then
        source $HOME/.asdf/asdf.sh
        source $HOME/.asdf/completions/asdf.bash
    fi

    # --------------------------------------------------
    # Android
    export ANDROID_HOME="$HOME/Android/sdk"

    # --------------------------------------------------
    # irssi

    [ -f "$HOME/.irssi/passwords" ] && source "$HOME/.irssi/passwords"

    # --------------------------------------------------
    # Other

    export DICTIONARY="british"
    export PAGER="/usr/bin/less -R"
    export HISTCONTROL="ignoreboth"
    export HISTSIZE="100000"
    export ANSIBLE_NOCOWS=1
    export ERL_AFLAGS="-kernel shell_history enabled"
fi

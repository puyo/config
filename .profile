# ~/.profile: executed by the command interpreter for login shells.

if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
    # --------------------------------------------------
    # $PATH
    paths="
    $HOME/.cargo/bin \
    /usr/local/share/npm/bin \
    /usr/X11/bin \
    $HOME/bin \
    $ANDROID_HOME/tools \
    $ANDROID_HOME/platform-tools \
    /usr/local/bin \
    /usr/local/sbin"
    for p in $paths; do
        [ -d $p ] && PATH="$PATH:$p"
    done
    export PATH

    # --------------------------------------------------
    # Ruby

    if [ -d "$HOME/.rvm/bin" ]; then
        PATH="$PATH:$HOME/.rvm/bin"
    fi
    if [ -d /usr/local/share/chruby ]; then
        source /usr/local/share/chruby/chruby.sh

        case "$TERM" in
          xterm*|rxvt*|screen*)
            # chruby is awful :( It uses trap which is fired after I need it to be,
            # about 20 times, and also means I cannot use my own PROMPT_COMMAND.
            # Write our own version for use like this: PROMPT_COMMAND=chruby_auto

            # source /usr/local/share/chruby/auto.sh

            unset RUBY_AUTO_VERSION
            function chruby_auto() {
              local dir="$PWD/" version
              until [[ -z "$dir" ]]; do
                dir="${dir%/*}"
                if { read -r version <"$dir/.ruby-version"; } 2>/dev/null || [[ -n "$version" ]]; then
                    if [[ "$version" == "$RUBY_AUTO_VERSION" ]]; then return
                    else
                      RUBY_AUTO_VERSION="$version"
                      chruby "$version"
                      return $?
                    fi
                fi
              done
              if [[ -n "$RUBY_AUTO_VERSION" ]]; then
                  chruby_reset
                  unset RUBY_AUTO_VERSION
	            fi
            }
            PROMPT_COMMAND="chruby_auto"
            ;;
        esac
    fi

    # --------------------------------------------------
    # asdf (Elixir, Ruby, Erlang)

    if [ -d "$HOME/.asdf" ]; then
      source $HOME/.asdf/asdf.sh
      source $HOME/.asdf/completions/asdf.bash
    fi

    # --------------------------------------------------
    # Node

    # PATH="$PATH:./node_modules/.bin" # Add node modules bin path
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    # export PATH="$PATH:`yarn global bin --offline`" # yarn

    # --------------------------------------------------
    # asdf (Elixir, Ruby, Erlang)

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

export PATH="$PATH:$HOME/.cargo/bin"
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export PATH="/usr/local/opt/postgresql@10/bin:$PATH"
export GOPATH=$HOME/go
export PATH=$PATH:${GOPATH//://bin:}/bin

# ~/.profile: executed by the command interpreter for login shells.

if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
  # --------------------------------------------------
  # Android
  export ANDROID_HOME="$HOME/Android/sdk"

  # --------------------------------------------------
  # $PATH
  paths=(
    "/usr/local/opt/postgresql@12/bin"
    "$HOME/.cargo/bin"
    "/usr/local/share/npm/bin"
    "/usr/X11/bin"
    "$HOME/bin"
    "$ANDROID_HOME/tools"
    "$ANDROID_HOME/platform-tools"
    "/usr/local/bin"
    "/usr/local/sbin"
  )

  for p in ${paths[@]}; do
    if [ -d "$p" ]; then
      PATH="${PATH}:$p"
    fi
  done
  export PATH

  # --------------------------------------------------
  # asdf (Elixir, Ruby, Erlang, Node)

  if [ -d "$HOME/.asdf" ]; then
    source $HOME/.asdf/asdf.sh
  fi

  # --------------------------------------------------
  # Node (NVM)

  if [ -d "$HOME/.nvm" ]; then
    PATH="$PATH:./node_modules/.bin" # Add node modules bin path
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    # export PATH="$PATH:`yarn global bin --offline`" # yarn
  fi

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
  export KERL_CONFIGURE_OPTIONS="--without-javac --disable-debug --without-odbc"
fi

export GOPATH=$HOME/go
export PATH=$PATH:${GOPATH//://bin:}/bin

[ -f "$HOME/.blake" ] && . "$HOME/.blake"

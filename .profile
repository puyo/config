# ~/.profile: executed by the command interpreter for login shells.

if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
  # --------------------------------------------------
  # Android
  export ANDROID_HOME="$HOME/Android/sdk"

  # fly
  export FLYCTL_INSTALL="${HOME}/.fly"

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
    "$FLYCTL_INSTALL/bin"
  )

  for p in ${paths[@]}; do
    if [ -d "$p" ]; then
      PATH="${PATH}:$p"
    fi
  done
  export PATH

  # --------------------------------------------------
  # asdf (Elixir, Ruby, Erlang, Node)

  if [ -f "$HOME/.asdf/asdf.sh" ]; then
    . "$HOME/.asdf/asdf.sh"
  fi

  # --------------------------------------------------
  # Other

  export BROWSER="/usr/bin/firefox"
  export DICTIONARY="british"
  export PAGER="/usr/bin/less -R"
  export HISTCONTROL="ignoreboth"
  export HISTSIZE="100000"
  export ANSIBLE_NOCOWS=1
  export ERL_AFLAGS="-kernel shell_history enabled"
  export KERL_CONFIGURE_OPTIONS="--without-javac --disable-debug --without-odbc"
fi

# go
export GOPATH="$HOME/go"
export PATH="$PATH:${GOPATH//://bin:}/bin"

# qt
export QT_QPA_PLATFORMTHEME=qt5ct

[ -f "$HOME/.blake" ] && . "$HOME/.blake"

# ~/.profile: executed by the command interpreter for login shells.

if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
  # --------------------------------------------------
  # $PATH
  paths=(
    "$HOME/bin"
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "/usr/local/share/npm/bin"
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
[ -f "$HOME/.nearmap/profile.bash" ] && . "$HOME/.nearmap/profile.bash"

# ~/.profile: executed by the command interpreter for login shells.

if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
  # --------------------------------------------------
  # $PATH
  paths=(
    "$HOME/bin"
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$HOME/.config/emacs/bin"
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
  # Other

  export BROWSER="librewolf"
  export DICTIONARY="british"
  export PAGER="less -R"
  export HISTCONTROL="ignoreboth"
  export HISTSIZE="100000"
  export ANSIBLE_NOCOWS=1
  export ERL_AFLAGS="-kernel shell_history enabled"
  export KERL_CONFIGURE_OPTIONS="--without-javac --disable-debug --without-odbc"
  export PGPORT=5434
fi

# go
export GOPATH="$HOME/go"
export PATH="$PATH:${GOPATH//://bin:}/bin"

# qt
export QT_QPA_PLATFORMTHEME=qt5ct

[ -f "$HOME/nm/profile.bash" ] && . "$HOME/nm/profile.bash"

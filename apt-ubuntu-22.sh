apt_install=sudo apt install -y --without-recommends

$(apt_install) aptitude blender curl dict dosfstools emacs exuberant-ctags git htop imagemagick inkscape irssi manpages-dev ruby samba unrar unzip vim-gtk vlc wbritish wine zip

# asdf elixir
$(apt_install) autoconf fop libgl1-mesa-dev libglu1-mesa-dev libmysqlclient-dev libncurses5-dev libpng-dev libpq-dev libreadline-dev libssh-dev libwxgtk3.0-dev m4 unixodbc-dev xsltproc

# asdf erlang
$(apt_install) autoconf build-essential fop libgl1-mesa-dev libglu1-mesa-dev libncurses-dev libncurses5-dev libpng-dev libssh-dev libwxgtk-webview3.0-gtk3-dev libwxgtk3.0-gtk3-dev libxml2-utils m4 unixodbc-dev xsltproc

# asdf ruby
$(apt_install) autoconf bison build-essential libdb-dev libffi-dev libgdbm-dev libgdbm6 libncurses5-dev libreadline6-dev libssl-dev libyaml-dev uuid-dev zlib1g-dev

# bevy
$(apt_install) g++ pkg-config libx11-dev libasound2-dev libudev-dev

# postgresql server
$(apt_install) postgresql libpq-dev

# ssh server
$(apt_install) openssh-server

# htop
$(apt_install) htop

# diff-so-fancy
sudo add-apt-repository ppa:aos1/diff-so-fancy
$(apt_install) diff-so-fancy

# github cli
$(apt_install) gh

# wmctrl (gvim wrapper)
$(apt_install) wmctrl

# jq (json pretty printer / query)
$(apt_install) jq



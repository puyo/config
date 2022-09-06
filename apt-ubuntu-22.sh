#!/bin/bash

set -xeuo pipefail

# no recommends kthx
sudo tee /etc/apt/apt.conf.d/99_norecommends << 'EOF'
APT::Install-Recommends "false";
APT::AutoRemove::RecommendsImportant "false";
APT::AutoRemove::SuggestsImportant "false";
EOF

# unattended upgrades
sudo apt install -y unattended-upgrades

# firefox (remove snap version, install apt version)
sudo snap remove firefox
sudo add-apt-repository -y ppa:mozillateam/ppa
sudo apt install -y firefox
echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo tee /etc/apt/preferences.d/mozilla-firefox
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | \
  sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

# various
sudo apt install -y aptitude blender curl dict dosfstools emacs exuberant-ctags git \
  htop imagemagick inkscape irssi manpages-dev ruby samba unrar unzip vim-gtk vlc \
  wbritish wine zip

# asdf elixir
sudo apt install -y autoconf fop libgl1-mesa-dev libglu1-mesa-dev libmysqlclient-dev libncurses5-dev libpng-dev libpq-dev libreadline-dev libssh-dev m4 unixodbc-dev xsltproc

# asdf erlang
sudo apt install -y autoconf build-essential fop libgl1-mesa-dev libglu1-mesa-dev libncurses-dev libncurses5-dev libpng-dev libssh-dev libwxgtk-webview3.0-gtk3-dev libwxgtk3.0-gtk3-dev libxml2-utils m4 unixodbc-dev xsltproc

# asdf ruby
sudo apt install -y autoconf bison build-essential libdb-dev libffi-dev libgdbm-dev libgdbm6 libncurses5-dev libreadline6-dev libssl-dev libyaml-dev uuid-dev zlib1g-dev

# bevy
sudo apt install -y g++ pkg-config libx11-dev libasound2-dev libudev-dev

# postgresql server
sudo apt install -y postgresql libpq-dev

# ssh server
sudo apt install -y openssh-server

# htop
sudo apt install -y htop

# diff-so-fancy
sudo add-apt-repository -y ppa:aos1/diff-so-fancy
sudo apt install -y diff-so-fancy

# github cli
sudo apt install -y gh

# wmctrl (gvim wrapper)
sudo apt install -y wmctrl

# jq (json pretty printer / query)
sudo apt install -y jq

# aws cli
sudo apt install -y awscli

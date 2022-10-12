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
sudo apt install -y \
  aptitude \
  blender \
  curl \
  dict \
  dosfstools \
  emacs \
  exuberant-ctags \
  git \
  htop \
  imagemagick \
  inkscape \
  irssi \
  manpages-dev \
  net-tools \
  ruby \
  samba \
  unrar \
  unzip \
  vim-gtk \
  vlc \
  wbritish \
  wine \
  zip

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

# shell check
sudo apt install -y shellcheck

# spotify
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install spotify-client

# albert
echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_22.04/ /' | sudo tee /etc/apt/sources.list.d/home:manuelschneid3r.list
curl -fsSL https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_22.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_manuelschneid3r.gpg > /dev/null
sudo apt update
sudo apt install albert

# pulseaudio - headphones have higher priority than laptop speakers
sudo sed -i 's/priority = 100/priority = 98/g' /usr/share/pulseaudio/alsa-mixer/paths/analog-output-speaker.conf

# pulseaudio - add a profile with all devices enabled so we can switch between them more easily
if ! grep -q "All Output" /usr/share/pulseaudio/alsa-mixer/profile-sets/default.conf; then
  echo "Adding 'All Output' profile to /usr/share/pulseaudio/alsa-mixer/profile-sets/default.conf"
  sudo "${SHELL}" -c "echo '
[Profile output:all+input:all]
description = All Output
output-mappings = hdmi-stereo analog-stereo
input-mappings = analog-stereo
' >> /usr/share/pulseaudio/alsa-mixer/profile-sets/default.conf"
fi

sudo apt install -y \
  okular \
  command-not-found \
  avahi-daemon \
  bash-completion

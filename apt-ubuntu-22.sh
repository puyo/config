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
sudo apt remove -y firefox
sudo add-apt-repository -y ppa:mozillateam/ppa
echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo tee /etc/apt/preferences.d/mozilla-firefox
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | \
  sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

packages=(
  aptitude                     # apt UI
  avahi-daemon                 # dns discovery, mDNS
  bash-completion              # shell tab completion
  blender                      # 3D graphics
  command-not-found            # suggest uninstalled programs
  cups                         # printer support
  curl                         # download over HTTP
  dict                         # dictionary
  dolphin                      # file manager
  dosfstools                   # fix line endings
  emacs                        # editor
  exuberant-ctags              # code indexer
  firefox                      # browser
  fonts-hack                   # font
  friendly-recovery            # recovery boot mode menu
  geoip-database               # IP geo lookup
  gh                           # github cli
  git                          # version control
  gwenview                     # image viewer
  htop                         # task monitor
  imagemagick                  # image conversion on command line
  inkscape                     # vector graphics
  iptables                     # firewall
  iputils-tracepath            # souped up traceroute
  irssi                        # irc client
  jq                           # jq (json pretty printer / query)
  kamera                       # digital camera support
  kate                         # text editor
  kcalc                        # calculator
  kde-config-gtk-style         # gtk style config
  kde-config-gtk-style-preview # gtk style config
  kde-config-screenlocker      # screen lock config
  kde-config-tablet            # wacom tablet support
  kde-config-whoopsie          # configure error reporting to canonical
  kde-spectacle                # screen capture app
  kdeconnect                   # smartphone integration
  kerneloops                   # report kernal crashes
  kwalletmanager               # manage passwords
  manpages-dev                 # manual pages for devs
  mesa-utils                   # check 3D acceleration is working
  mesa-vulkan-drivers          # faster 3D drivers
  net-tools                    # ifconfig and similar command line tools
  network-manager              # wifi connection manager
  okular                       # pdf and document viewer
  okular-extra-backends        # okular epub support
  openssh-server               # ssh into this machine
  p7zip-full                   # decommpress files
  partitionmanager             # manage partitions
  pavucontrol-qt               # pulseaudio volume control
  pipewire                     # multimedia server
  plasma-browser-integration   # media control, download notifications
  plasma-discover              # software library
  plasma-disks                 # alert about failing S.M.A.R.T. hard disks
  plasma-firewall              # firewall graphical config
  plasma-systemmonitor         # show sensor info
  plasma-thunderbolt           # manage thunderbolt devices
  plasma-vault                 # manage encrypted folders
  plasma-widgets-addons        # various widgets including nightcolor control
  plymouth                     # boot logo
  plymouth-theme-spinner       # basic boot logo theme
  pm-utils                     # suspend/hibernate from command line
  print-manager                # KDE printer manager
  pulseaudio-module-bluetooth  # play audio on bluetooth
  ruby                         # interpreter for many of my scripts
  samba                        # share files with windows machines on the network
  secureboot-db                # manage secureboot database
  shellcheck                   # shell check
  smbclient                    # windows file sharing
  telnet                       # test networks
  thermald                     # monitor computer temperature
  unrar                        # decompress files
  unzip                        # decompress files
  vim-gtk                      # editor
  vlc                          # media player
  vulkan-tools                 # vulkaninfo
  wbritish                     # british dictionary
  wine                         # windows emulator
  wmctrl                       # wmctrl (gvim wrapper)
  xserver-xorg-video-all       # video card drivers (does not include intel)
  xserver-xorg-video-intel     # video card drivers for intel
  xsettingsd                   # gnome app support in non-gnome environment
  zip                          # decompress files
)

sudo apt install -y "${packages[@]}"

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

# diff-so-fancy
sudo add-apt-repository -y ppa:aos1/diff-so-fancy
sudo apt install -y diff-so-fancy

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

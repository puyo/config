#!/bin/bash

set -xeuo pipefail

# no recommends kthx
sudo tee /etc/apt/apt.conf.d/99_norecommends <<'EOF'
APT::Install-Recommends "false";
APT::AutoRemove::RecommendsImportant "false";
APT::AutoRemove::SuggestsImportant "false";
EOF

# firefox (remove snap version, install apt version)
sudo snap remove firefox
sudo apt remove -y firefox
sudo add-apt-repository -y ppa:mozillateam/ppa
echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo tee /etc/apt/preferences.d/mozilla-firefox
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' |
  sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

sudo add-apt-repository -y ppa:neovim-ppa/unstable

packages=(
  alsa-ucm-conf            # needed for output to audio device plugged into screen
  apparmor                 # security policies
  aptitude                 # apt UI
  at-spi2-core             # prevents a warning in emacs start up
  automake
  autotools-dev
  bash-completion          # shell tab completion
  blender                  # 3D graphics
  cmake                    # needed to build some gems
  curl                     # download over HTTP
  dict                     # dictionary
  dosfstools               # fix line endings
  editorconfig             # used by Doom Emacs
  emacs                    # editor
  fd-find                  # used by Doom Emacs
  ffmpeg                   # work with videos
  firefox                  # browser
  firmware-sof-signed      # intel audio drivers
  fonts-droid-fallback
  fonts-lato
  fonts-liberation-sans-narrow
  fonts-liberation2
  fonts-noto               # unicode characters
  fonts-noto-cjk
  fonts-noto-cjk-extra
  fonts-noto-extra
  fonts-noto-hinted
  fonts-noto-ui-core
  gh                       # github cli
  git                      # version control
  htop                     # task monitor
  imagemagick              # image conversion on command line
  inkscape                 # vector graphics
  inotify-tools            # Elixir Phoenix uses this
  jq                       # jq (json pretty printer / query)
  kubuntu-wallpapers-focal # milky way wallpaper
  less                     # terminal pager
  libdbus-1-dev            # for cargo install kdotool
  lm-sensors
  manpages-dev             # manual pages for devs
  mesa-utils               # check 3D acceleration is working
  mesa-vulkan-drivers      # faster 3D drivers
  mtr-tiny                 # ping/traceroute
  neovim-qt                # modernised vim with lua
  net-tools                # ifconfig and similar command line tools
  ntp                      # time sync
  openssh-server           # ssh into this machine
  partitionmanager         # manage partitions
  plocate
  plymouth-theme-kubuntu-logo
  plymouth-theme-spinner   # basic boot logo theme
  pm-utils                 # suspend/hibernate from command line
  ripgrep                  # used by Doom Emacs
  ruby                     # interpreter for many of my scripts
  shellcheck               # shell check
  shfmt                    # used by Doom Emacs
  strace                   # debug programs
  systemd-resolved
  telnet                   # test networks
  unattended-upgrades      # unattended security upgrades
  universal-ctags          # code indexer
  vim-gtk3                 # editor
  vlc                      # media player
  vulkan-tools             # vulkaninfo
  wayland-utils
  wbritish                 # british dictionary
  whois                    # domain name info
  wine                     # windows emulator
  winetricks
  wl-clipboard             # wl-copy, wl-paste for neovim
  wmctrl                   # wmctrl (gvim wrapper)
)

sudo apt install -y "${packages[@]}"

# bevy
sudo apt install -y g++ pkg-config libx11-dev libasound2-dev libudev-dev

# postgresql server
sudo apt install -y postgresql libpq-dev
sudo -u postgres createuser -d -r -s "${USER}"
createdb "${USER}"

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
curl -fsSL https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_22.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_manuelschneid3r.gpg >/dev/null
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

  pulseaudio -k
fi

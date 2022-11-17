#!/bin/bash

set -xeuo pipefail

# no recommends kthx
sudo tee /etc/apt/apt.conf.d/99_norecommends << 'EOF'
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
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | \
  sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

packages=(
  acpi-support                  # detect lid closure, AC power, etc.
  apparmor                      # linux security system
  apport-kde                    # crash reports
  apport-symptoms               # crash reports extra info
  aptitude                      # apt UI
  ark                           # app for opening compressed files
  avahi-daemon                  # dns discovery, mDNS
  bash-completion               # shell tab completion
  blender                       # 3D graphics
  breeze-gtk-theme              # gtk app theme to match qt apps
  cmake                         # needed to build some gems
  command-not-found             # suggest uninstalled programs
  cups                          # printer support
  curl                          # download over HTTP
  dict                          # dictionary
  dolphin                       # file manager
  dosfstools                    # fix line endings
  emacs                         # editor
  exuberant-ctags               # code indexer
  ffmpegthumbs                  # video thumbnails in dolphin
  firefox                       # browser
  firmware-sof-signed           # intel audio driver
  fonts-hack                    # font
  fonts-noto-color-emoji        # emoji
  fonts-noto-core               # emoji font
  friendly-recovery             # recovery boot mode menu
  fwupd                         # firmware management
  fwupd-signed                  # firmware management
  geoip-database                # IP geo lookup
  gh                            # github cli
  git                           # version control
  gnupg-agent                   # digitally signed messages
  gstreamer-qapt                # recommend/install video codecs
  gstreamer1.0-pulseaudio:i386  # firestorm voice
  gwenview                      # image viewer
  htop                          # task monitor
  imagemagick                   # image conversion on command line
  inkscape                      # vector graphics
  inotify-tools                 # Elixir Phoenix uses this
  iptables                      # firewall
  iputils-ping                  # ping
  iputils-tracepath             # souped up traceroute
  irqbalance                    # improve performance on multiple cores
  irssi                         # irc client
  jq                            # jq (json pretty printer / query)
  kamera                        # digital camera support
  kate                          # text editor
  kcalc                         # calculator
  kde-config-gtk-style          # gtk style config
  kde-config-gtk-style-preview  # gtk style config
  kde-config-screenlocker       # screen lock config
  kde-config-sddm               # login screen config
  kde-config-tablet             # wacom tablet support
  kde-config-whoopsie           # configure error reporting to canonical
  kde-spectacle                 # screen capture app
  kdeconnect                    # smartphone integration
  kdegraphics-thumbnailers      # thumbnails
  kdialog                       # used by autokey-qt
  kerneloops                    # report kernal crashes
  kimageformat-plugins          # support for various image formats
  kio-fuse                      # KDE fuse support (for NTFS)
  kscreen                       # KDE monitor hot plug support
  kubuntu-notification-helper   # notifications about crashes, upgrades, reboots
  kwalletmanager                # manage passwords
  kwin-addons                   # KDE simple task switcher
  less                          # terminal pager
  libidn12:i386                 # firestorm voice
  manpages-dev                  # manual pages for devs
  memtest86+                    # memory testing on boot
  mesa-utils                    # check 3D acceleration is working
  mesa-vulkan-drivers           # faster 3D drivers
  mscompress                    # decompress files
  mtr-tiny                      # ping/traceroute
  net-tools                     # ifconfig and similar command line tools
  network-manager               # wifi connection manager
  ntfs-3g                       # NTFS support
  okular                        # pdf and document viewer
  okular-extra-backends         # okular epub support
  openssh-server                # ssh into this machine
  p7zip-full                    # decommpress files
  partitionmanager              # manage partitions
  patchelf                      # firestorm voice
  pavucontrol-qt                # pulseaudio volume control
  pipewire                      # multimedia server
  plasma-browser-integration    # KDE media control, download notifications
  plasma-discover               # KDE app store
  plasma-discover-backend-fwupd # KDE manage firmware
  plasma-disks                  # KDE alert about failing S.M.A.R.T. hard disks
  plasma-firewall               # KDE firewall config
  plasma-nm                     # KDE network manager applet
  plasma-pa                     # KDE audio manager applet
  plasma-systemmonitor          # KDE show sensor info
  plasma-thunderbolt            # KDE manage thunderbolt devices
  plasma-vault                  # KDE manage encrypted folders
  plasma-widgets-addons         # KDE various widgets including nightcolor control
  plymouth                      # boot logo
  plymouth-theme-spinner        # basic boot logo theme
  pm-utils                      # suspend/hibernate from command line
  print-manager                 # KDE printer manager
  printer-driver-postscript-hp  # HP printer drivers
  pulseaudio-module-bluetooth   # play audio on bluetooth
  rsyslog                       # system logs
  ruby                          # interpreter for many of my scripts
  samba                         # share files with windows machines on the network
  sddm                          # login screen
  secureboot-db                 # manage secureboot database
  shellcheck                    # shell check
  smbclient                     # windows file sharing
  strace                        # debug programs
  telnet                        # test networks
  thermald                      # monitor computer temperature
  ufw                           # firewall CLI
  unar                          # decompress files
  unattended-upgrades           # unattended upgrades
  unrar                         # decompress files
  unzip                         # decompress files
  upower                        # power supply info
  va-driver-all                 # all video drivers
  vdpau-driver-all              # video decoding via graphics cards
  vim-gtk                       # editor
  vlc                           # media player
  vulkan-tools                  # vulkaninfo
  wbritish                      # british dictionary
  whois                         # domain name info
  wine                          # windows emulator
  wmctrl                        # wmctrl (gvim wrapper)
  xfonts-scalable               # some basic fonts
  xserver-xorg-video-all        # video card drivers (does not include intel)
  xserver-xorg-video-intel      # video card drivers for intel
  xsettingsd                    # gnome app support in non-gnome environment
  zip                           # decompress files
  zstd                          # decompress files
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

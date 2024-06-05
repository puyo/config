#!/bin/bash

set -xeuo pipefail

# firefox (remove snap version, install apt version)
sudo snap remove firefox || echo "No snap, good"
sudo apt remove -y firefox || echo "Firefox already uninstalled"
sudo add-apt-repository -y ppa:mozillateam/ppa

echo 'Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo tee /etc/apt/preferences.d/mozilla-firefox

echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' |
  sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

sudo apt install firefox

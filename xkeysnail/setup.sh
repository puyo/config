#!/bin/sh

sudo service xkeysnail stop
sudo cp xkeysnail.init.d.sh /etc/init.d/xkeysnail
sudo mkdir -p /etc/xkeysnail
sudo cp config.py /etc/xkeysnail/config.py
sudo chown root:root /etc/init.d/xkeysnail
sudo update-rc.d xkeysnail defaults
sudo service xkeysnail restart

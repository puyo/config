#!/bin/bash

# NOTE: This does not work because udev invokes it but when it runs, pactl list
# sinks does not show the new sink, even if I name the udev rule
# "99-pulse-hdmi.rules" to try to make it run last.
#
# Use auto-switch.rb instead.
#

user_pactl() {
  PID=$(pgrep pulseaudio)
  USER=$(grep -z USER= /proc/$PID/environ | tr -d '\0' | sed 's/.*=//')
  sudo -u $USER env XDG_RUNTIME_DIR=/run/user/$(id -u $USER) pactl $*
}

SINK=`user_pactl list sinks short | tail -1 | cut -f 1`

sudo echo "-----" >> /tmp/sink.log
sudo echo $(date) >> /tmp/sink.log

ser_pactl list sinks short >> /tmp/sink.log

sudo echo "Switching to sink $SINK" >> /tmp/sink.log

user_pactl set-default-sink $SINK

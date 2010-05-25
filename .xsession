#!/bin/sh 

docker -wmaker &
wmitime -12 &
wmcpuload &
wmtop -a 2 &
wmnet -W eth0 -wlr darkcyan -x 100000 &
wmmemload -b -c &
wmhdplop &
wmmixer -w -l darkcyan -L cyan &
checkgmail &
gnome-do &
xscreensaver -no-splash &
update-notifier &

setxkbmap -option terminate:ctrl_alt_bksp

[ -f ~/.xprofile ] && . ~/.xprofile
exec /usr/bin/dbus-launch --exit-with-session /usr/bin/wmaker

#!/bin/sh 

#docker -wmaker &
wmitime -12 &
wmcpuload &
wmtop -a 2 &
wmnet -W eth0 -wlr darkcyan -x 100000 &
wmmemload -b -c &
wmhdplop &
wmmixer -w -l darkcyan -L cyan &

xscreensaver -no-splash &
update-notifier-kde &

export LC_ALL=C

[ -f ~/.xprofile ] && . ~/.xprofile
exec /usr/bin/wmaker

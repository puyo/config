#!/bin/sh 

[ -f ~/.xprofile ] && . ~/.xprofile
setxkbmap -option terminate:ctrl_alt_bksp
exec /bin/sh /etc/xdg/xfce4/xinitrc -- /etc/X11/xinit/xserverrc

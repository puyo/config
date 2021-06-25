#!/bin/sh

### BEGIN INIT INFO
# Provides:		xkeysnail
# Required-Start:	$all
# Required-Stop:	$all
# Should-Start:
# Should-Stop:
# Default-Start:	2 3 4 5
# Default-Stop:		0 6
# Short-Description:	Custom keyboard shortcuts
### END INIT INFO

PATH="/sbin:/bin:/usr/sbin:/usr/bin"
NAME="xkeysnail"
DESC="Per-application keyboard customisation"
PIDFILE=/var/run/xkeysnail.pid
DAEMON=/usr/local/bin/xkeysnail
DAEMON_OPTS="/etc/xkeysnail/config.py"
export DISPLAY=:0.0

. /lib/lsb/init-functions

set -e

start_xkeysnail() {
    start-stop-daemon --start --background --make-pidfile --pidfile $PIDFILE --exec $DAEMON -- $DAEMON_OPTS
}

stop_xkeysnail() {
    start-stop-daemon --stop --remove-pidfile --pidfile $PIDFILE
    synclient TouchpadOff=0
}

case "${1}" in
  start)
    start_xkeysnail
    ;;

  stop)
    stop_xkeysnail
    ;;

  restart|force-reload)
    stop_xkeysnail
    start_xkeysnail
    ;;

  *)
    echo "Usage: ${0} {start|stop|restart|force-reload}" >&2
    exit 1
    ;;
esac

exit 0

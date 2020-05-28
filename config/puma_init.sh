#!/bin/sh

### BEGIN INIT INFO
# Provides:          puma
# Required-Start:    $all
# Required-Stop:     $all
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts the puma app server
# Description:       starts puma using start-stop-daemon
### END INIT INFO

# This file should be linked to: /etc/init.d/puma_rails_myapp
# It should be called via: sudo service puma_rails_myapp restart

set -e

USAGE="Usage: $0 <start|stop|restart|upgrade|rotate|force-stop>"

# app settings
USER="maneyko"
APP_NAME="rails_myapp"
APP_ROOT="/var/www/rails_myapp"
ENV="production"

# environment settings
CMD="cd $APP_ROOT && bundle exec puma -C config/puma.rb -e $ENV -d"
PID="$APP_ROOT/tmp/pids/puma.pid"

# make sure the app exists
cd $APP_ROOT || exit 1

sig () {
  test -s "$PID" && kill -$1 `cat $PID`
}

app_start() {
  sig 0 && echo >&2 "Already running" && exit 0
  echo "Starting $APP_NAME"
  su - $USER -c "$CMD"
}

app_stop() {
  echo "Stopping $APP_NAME"
  sig QUIT || echo >&2 "Not running"
  sleep 1
}

case $1 in
  start)
    app_start
    ;;
  stop)
    app_stop
    ;;
  force-stop)
    echo "Force stopping $APP_NAME"
    sig TERM && exit 0
    echo >&2 "Not running"
    ;;
  restart|reload|upgrade)
    app_stop
    app_start
    ;;
  rotate)
    sig USR1 && echo rotated logs OK && exit 0
    echo >&2 "Couldn't rotate logs" && exit 1
    ;;
  *)
    echo >&2 $USAGE
    exit 1
    ;;
esac

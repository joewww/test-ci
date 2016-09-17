#!/bin/bash

# Wrapper script to start/stop nginx

MAIN_CONFIG="/etc/nginx/nginx.conf"
CONFIG="/etc/nginx/conf.d/default.conf"

function start_nginx {
  cp /tmp/$ENVIRON.conf $CONFIG

  sed -i 's/listen 80\;/listen '"$PORT"'\;/g' $CONFIG

#debugging
cat $CONFIG
cat $MAIN_CONFIG

  nginx -t
  nginx -g 'daemon off;'

}


if [ "$ENVIRON" = 'prod' ];then
  echo "!!! LOADING PRODUCTION..."

# worker_processes 50;
  sed -i 's/worker_processes.*;$/worker_processes 50\;/g' $MAIN_CONFIG
# worker_rlimit_nofile 8192;
  sed -i 's/worker_rlimit_nofile.*;$/worker_rlimit_nofile 8192\;/g' $MAIN_CONFIG
# worker_connections 4096;
  sed -i 's/worker_connections.*;$/worker_connections 4096\;/g' $MAIN_CONFIG

  start_nginx
 
elif [ "$ENVIRON" = 'dev' ];then
  echo "!!! LOADING DEVELOPMENT..."

# worker_processes 10;
  sed -i 's/worker_processes.*;$/worker_processes 10\;/g' $MAIN_CONFIG
# worker_rlimit_nofile 4096;
  sed -i 's/worker_rlimit_nofile.*;$/worker_rlimit_nofile 4096\;/g' $MAIN_CONFIG
# worker_connections 1024;
  sed -i 's/worker_connections.*;$/worker_connections 1024\;/g' $MAIN_CONFIG

  start_nginx

else
  echo "ERROR: environment: \$ENVIRON: $ENVIRON"
fi


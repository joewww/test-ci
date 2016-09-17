#!/bin/bash

function usage {
  echo "usage:"
  echo "run.sh <dev/prod> <port>"
  exit 1;
}

if [ -z "$1" ];then
  usage
else
  ENVIRON="$1"
fi

if [ -z "$2" ];then
  usage
else
  PORT="$2"
fi

docker run --entrypoint /start-nginx.sh --env ENVIRON=$ENVIRON --env PORT=$PORT joew/nginx-build

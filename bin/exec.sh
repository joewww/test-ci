#!/bin/bash

function usage {
  echo "Usage"
  echo "$0 <command>"
  exit 1
}

if [ -z "$1" ];then
  usage
else
  CMD="$1"
fi

for container in `docker ps -a|awk '{print $1}'|grep -v CONTAINER`;do 
  echo "Container: $container"
  docker exec -i -t $container $CMD
  echo
done

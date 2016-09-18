#!/bin/bash

PORT="5000"

function build {
  ./build.sh
}
function run {
  ./run.sh dev $PORT &
}
function test {
  sleep 3
  # test for /var/www/index.html
  ./exec.sh "curl localhost:$PORT"|grep Hello 

  if [ $? -eq 0 ];then
    echo "curl test passed on port $PORT"
  else
    echo "curl test failed."
    exit 1
  fi
}

#build
#run
#test

shellcheck bin/*

# EOF

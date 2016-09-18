#!/bin/bash

# Cleanup old containers

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

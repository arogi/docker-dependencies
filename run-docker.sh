#!/bin/bash

docker run \
  --name arogi-demo-host \
  -d \
  -p 80:80 \
  arogi/docker-web

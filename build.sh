#!/bin/bash

DIRECTORY=conf
if [ ! -d "$DIRECTORY" ]; then

  git clone \
    --depth=1 \
    --recurse-submodules \
    --single-branch \
    --branch=master https://github.com/arogi/docker-arogi-demos.git
fi

docker build \
  --tag arogi/docker-web \
  --force-rm \
  .

#!/bin/bash
curl https://api.tinify.com/shrink \
  --user api:${TINIFY_KEY} \
  --data-binary @${1} \
  --dump-header /dev/stdout

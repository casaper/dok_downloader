#!/bin/bash
set -e

bin/rails assets:clobber
bin/rails webpacker:compile
bin/rails assets:precompile

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

exec "$@"

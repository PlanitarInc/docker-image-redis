#!/bin/bash

set -ex

SCRIPT_DIR=$(dirname $(realpath $0))

cd /tmp

wget -nv http://download.redis.io/redis-stable.tar.gz
tar xzf redis-stable.tar.gz
cd redis-stable

patch -p0 <${SCRIPT_DIR}/00-add-os-module.diff

make
# XXX: skip `make test`

make PREFIX=/opt/redis install -C src

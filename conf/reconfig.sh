#!/bin/sh

ETCD_URL=http://172.17.42.1:4001

MASTER="$1"
ROLE="$2"
STATE="$3"
FROM_IP="$4"
FROM_PORT="$5"
TO_IP="$6"
TO_PORT="$7"

# echo "M=$MASTER, R=$ROLE, S=$STATE, ${FROM_IP}:${FROM_PORT} -> ${TO_IP}:${TO_PORT}; [$@]"

curl -L $ETCD_URL/v2/keys/skydns/ca/plntr/prd/redis \
  -XPUT -d value="{\"host\":\"${TO_IP}\"}"

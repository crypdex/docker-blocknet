#!/bin/sh
set -e

datadir="/home/blocknet/.blocknet"

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for blocknetdxd"

  set -- blocknetdxd "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "blocknetdxd" ]; then
  echo "Creating data directory ..."
  mkdir -p "$datadir"
  chmod 700 "$datadir"
  chown -R blocknet "$datadir"

  echo "$0: setting data directory to $datadir"

  set -- "$@" -datadir="$datadir"
fi

if [ "$1" = "blocknetdxd" ] || [ "$1" = "blocknetdx-cli" ] || [ "$1" = "blocknetdx-tx" ]; then
  echo "$@"
  exec su-exec blocknet "$@"
fi

echo
exec "$@"

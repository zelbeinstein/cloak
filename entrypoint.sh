#!/bin/sh
set -e

if [ "$1" != "ck-server" -a "$1" != "ck-client" ]; then
   echo "FAIL Cloak"
   echo "Use ck-server or ck-client command"
   exit 0
fi

exec "$@"

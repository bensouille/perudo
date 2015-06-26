#!/bin/bash

set -x
log()
{
echo -n "${1}"
[ -p '/tmp/perudo_*' ] && rm -f /tmp/perudo_*
a=0
for p in `top -n1 -b | grep perudoclt.sh | awk '{ print $2 }'` ; do
		mkfifo /tmp/perudo_${p}
		a=$(($a+1))
		echo ${1} > /tmp/perudo_${p}
done
}

log "test"
#!/usr/bin/env bash
##
#   Echo and log
#

LOG_FILE="test.log"

function log {
    LEVEL="${1}"
    TEXT="${2}"
    echo "$(date) [${BASH_SOURCE}]: ${TEXT}" >> "${LOG_FILE}"
    if [ "${LEVEL}" != "info" ]; then
	echo "${TEXT}" >&2
	if [ "${LEVEL}" = "fatal" ]; then
	    exit 1
	fi
    else
	echo "${TEXT}"
    fi

}

log info "test"
log warn "warn"
log fatal "error"

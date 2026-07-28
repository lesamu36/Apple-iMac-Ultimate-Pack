#!/bin/bash

LOGGER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="$LOGGER_DIR/../logs"
LOGFILE="$LOG_DIR/install.log"

mkdir -p "$LOG_DIR"

log() {
    echo "$(date '+%F %T') : $1" >> "$LOGFILE"
}

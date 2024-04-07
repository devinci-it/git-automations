#!/bin/bash

# Function to log errors
log_error() {
    local message="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] $message" >> "$ERROR_LOG"
}

# Function to log actions
log_action() {
    local message="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') [ACTION] $message" >> "$ACTION_LOG"
}

log() {
  if [[ $VERBOSE -eq 1 ]]; then
    echo "$@"
  fi
}

#!/bin/bash

######################################################################
# Git Template Hook Configuration Script
#
# Description:
#   This script reads a configuration file (hooks.conf) defining custom
#   scripts for Git hooks and prepares/builds the user's git_template
#   directory based on the provided script paths.
#
# Usage:
#   Edit the hooks.conf file to define custom scripts for each Git hook,
#   with the script paths relative to the project's 'hooks/custom-scripts'
#   directory. Then run this script to prepare/build the git_template
#   directory based on the settings provided in hooks.conf.
#
# Author:
#   [Your Name]
#
# Date:
#   [Date]
#
######################################################################
error_count =0;
# Function to write a hook script
write_hook_script() {
    local hook_type="$1"
    local script_name="$2"
    local hook_file=${hook_type,,}

    # Check if the hook script exists in the custom scripts directory
    if [ -f "$GIT_TEMPLATE_DIR/hooks/custom-scripts/$script_name" ]; then
        # Define the hook script path in the git template directory
        local hook_script_path="$GIT_TEMPLATE_DIR/hooks/$hook_file"

        # Create the hook script if it doesn't exist
        if [ ! -f "$hook_script_path" ]; then
            touch "$hook_script_path"
            chmod +x "$hook_script_path"
            log_action "Hook script '$hook_type' created."
        fi

        # Append the script content to the hook script
        echo "\$(git rev-parse --show-toplevel)/.git/hooks/custom-scripts/$script_name" >> "$hook_script_path"

        log_action "Script '$script_name' added to hook '$hook_type'."
    else
        log_error "Script '$script_name' not found in the custom scripts directory."
    fi
}

# Logging function
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

# Logging function for actions
log_action() {
    log "[ACTION] $1"
}

# Logging function for errors
log_error() {
    local message="$1"
    log "[ERROR] $message"
    echo "$(date '+%Y-%m-%d %H:%M:%S') [ACTION] $message" >> "$ERROR_LOG"
    error_count=$((error_count+1))
}

hook_type=""
while IFS= read -r line
do
    # Skip lines starting with # or ;
    if [[ $line == \#* || $line == \;* ]]; then
        continue
    fi

    # If line starts with [, it's a hook type
    if [[ $line == \[* ]]; then
        hook_type=${line//[\[\]]/}  # Remove [ and ]
        log "Set hook_type to $hook_type"
    elif [[ -n $hook_type ]]; then
        # It's a script name
        script_name=$line
        log "Set script_name to $script_name"
        write_hook_script "$hook_type" "$script_name"
    fi
done < "$HOOKS_CONF_FILE"

if [ $error_count -gt 0 ]; then
    log_error "There were $error_count errors while processing the hooks configuration."
    echo "There were $error_count errors while processing the hooks configuration. refer to $LOG_FILE/error.log for more details."
    exit 1
fi
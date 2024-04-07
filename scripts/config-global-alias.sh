#!/bin/bash

######################################################################
# config-global-alias.sh
#
# Description:
#   Configures Git aliases based on the settings provided in alias.conf.
#   It reads the configuration from alias.conf and registers Git aliases.
#   Additionally, it checks if the corresponding script exists in the
#   Git template directory and if it's executable. If not, it prompts
#   the user to ensure proper permissions.
#
# Usage:
#   Run this script to configure Git aliases based on the settings in alias.conf.
#   The script uses the .env file located one level above this script to set variables.
#   Ensure that alias.conf exists and contains valid script names and aliases.
#
# Author:
#   [Your Name]
#
# Date:
#   [Date]
#
######################################################################

# Get the path to the Git template directory from .env
source "$(dirname "${BASH_SOURCE[0]}")/../.env"

# Set the path to the alias configuration file using .env
ALIAS_CONF_FILE="$GIT_TEMPLATE_DIR/config/alias.conf"

# Check if alias.conf exists
if [ ! -f "$ALIAS_CONF_FILE" ]; then
    echo "Error: alias.conf not found in $ALIAS_CONF_FILE."
    exit 1
fi

# Read alias.conf and register aliases
while IFS=':' read -r script_name alias_name; do
    # Construct the path to the script
    script_path="$GIT_TEMPLATE_DIR/hooks/custom-scripts/$script_name"
    # Check if the script exists
    if [ ! -f "$script_path" ]; then
        echo "Error: Script $script_name not found in $GIT_TEMPLATE_DIR/hooks/custom-scripts."
        continue
    fi
    # Check if the script is executable
    if [ ! -x "$script_path" ]; then
        echo "Reminder: Please ensure that the script $script_name is executable."
        echo "You can make it executable using 'chmod +x $script_path'."
    fi
    # Register the Git alias
    git config --global alias.$alias_name "!$script_path"
    echo "Git alias '$alias_name' configured to execute the custom script '$script_name'."
done < "$ALIAS_CONF_FILE"

echo "All Git aliases configured."

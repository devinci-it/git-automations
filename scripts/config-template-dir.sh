#!/bin/bash

######################################################################
# Configure Git Template Directory
#
# Description:
#   This script imports the .env file from the parent directory to set
#   the global Git template directory. It then displays the initialized
#   template directory.
#
# Usage:
#   Run this script to configure the Git template directory using the
#   value specified in the .env file located in the parent directory.
#
# Author:
#   devinci-it
#
# Date:
#   2024
#
######################################################################

# Import .env file from parent directory
source "$(dirname "$0")/../.env"

# Set the global template directory
git config --global init.templatedir "$GIT_TEMPLATE_DIR"

# Echo the initialized template directory
echo "Init Template Directory: $(git config --global --get init.templatedir)"

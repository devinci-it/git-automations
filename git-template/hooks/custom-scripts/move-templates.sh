#!/bin/bash

######################################################################
# Move Templates Script
#
# Description:
#   This script moves template files from the git-template directory
#   to the root directory of the Git project.
#
# Usage:
#   Run this script after initializing the Git template directory
#   to move the template files to the root directory of the project.
#
# Author:
#   [Your Name]
#
# Date:
#   [Date]
#
######################################################################

# Define the path to the root directory of the Git project
PROJECT_DIR=$(git rev-parse --show-toplevel)

# Define the source directory containing the template files
TEMPLATES_DIR="$PROJECT_DIR/.git/templates"


# Define the destination directory (root directory of the project)
DESTINATION_DIR="$PROJECT_DIR"
if [[ -f "$TEMPLATES_DIR/gitignore.template" && -f "$TEMPLATES_DIR/README.template.md" ]]; then
  # Move the template files to the root directory
  mv "$TEMPLATES_DIR/gitignore.template" "$DESTINATION_DIR/.gitignore"
  mv "$TEMPLATES_DIR/README.template.md" "$DESTINATION_DIR/README.md"

  # Display success message
  echo "Template files moved to the root directory of the project."
else
  echo "Template files not found. Please validate your Git init.templatedir configuration with the following command:"
  echo "git config --global --get init.templatedir"
fi

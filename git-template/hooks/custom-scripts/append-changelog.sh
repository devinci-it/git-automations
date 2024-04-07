#!/bin/bash

######################################################################
# Git Prepare-commit-msg Hook Script: append-changelog.sh
#
# Description:
#   This script is a Git prepare-commit-msg hook that appends the content
#   of a temporary changelog file to the commit message. The changelog
#   content is extracted from files staged for commit using the pre-commit
#   hook script extract_changelogs.sh.
#
# Usage:
#   This script is automatically triggered after the commit message editor
#   is opened, before the commit message is finalized. It appends the
#   content of the temporary changelog file to the commit message.
#
# Author:
#   devinci-it
#
# Date:
#   2024 (c)
#
######################################################################

# Find the .git directory and set the path to the temporary changelog file
git_dir=$(git rev-parse --show-toplevel)
temp_changelog="$git_dir/.git/TEMP_CHANGELOG"

# Check if the temporary changelog file exists
if [ -f "$temp_changelog" ]; then
    # Append the content of the temporary changelog file to COMMIT_EDITMSG
    cat "$temp_changelog" >> "$1"
    echo "Changelog appended to the commit message."
fi

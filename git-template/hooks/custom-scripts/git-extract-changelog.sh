#!/bin/bash

######################################################################
# Git Changelog Extractor
#
# Description:
#   This script extracts changelog entries from files staged for commit in a Git repository.
#   It searches for a marker "GIT_CHANGELOG" in each file and extracts the lines following the marker.
#   The extracted changelog entries are appended to a temporary changelog file.
#
# Usage:
#   This script is automatically triggered before each commit when using Git.
#   It loops through the files staged for commit and extracts the changelog entries.
#   After processing all files, it displays the path of the temporary changelog file.
#
# Author:
#  devinci-it
#
# Date:
#  2024 (c)
#
######################################################################

# Check if the .git directory exists
if [ ! -d ".git" ]; then
    echo "Error: Not in a Git repository"
    exit 1
fi

# Find the .git directory and set the path to the temporary changelog file
git_dir=$(git rev-parse --git-dir)
temp_changelog="$git_dir/.git/TEMP_CHANGELOG"

# Function to extract changelog from a file
extract_changelog_from_file() {
    local file="$1"

    # Check if the file contains the marker
    if grep -q "GIT_CHANGELOG" "$file"; then
        echo "Processing file: $file"
        # Extract text from marker to EOF and append to temporary changelog file
        awk '/GIT_CHANGELOG/{flag=1; next} flag {print}' "$file" >> "$temp_changelog"
        echo "Changelog entries extracted from $file"
    fi
}

# Reset temporary changelog file
> "$temp_changelog"

# Iterate over all modified files
git diff --cached --name-only | while IFS= read -r file; do
    extract_changelog_from_file "$file"
done

# Print the path where the extracted text is saved
echo "Changelog entries saved to: $temp_changelog"

#!/bin/bash

# Function: generate_changelog_and_tag
#
# Description:
#   This function generates a changelog based on the changes in the latest commit
#   and creates a new tag with an incremented version number based on the type of changes.
#
# Arguments: None
#
# Returns: None

generate_changelog_and_tag() {
    # Get the latest version
    latest_version=$(git describe --tags --abbrev=0)

    # Increment version based on commit messages
    if git log --format=%B -n 1 HEAD | grep -Eq 'breaking'; then
        IFS='.' read -r major _ _ <<<"$latest_version"
        major=$((major + 1))
        new_version="$major.0.0"
    elif git log --format=%B -n 1 HEAD | grep -Eq 'enhancement|optimization|performance'; then
        IFS='.' read -r _ minor _ <<<"$latest_version"
        minor=$((minor + 1))
        new_version="0.$minor.0"
    else
        IFS='.' read -r _ _ patch <<<"$latest_version"
        patch=$((patch + 1))
        new_version="0.0.$patch"
    fi

    # Get the current date
    current_date=$(date +'%m-%d')

    # Generate header
    header="## v$new_version $current_date\n\n"

    # Initialize variables for changes
    added_files=""
    modified_files=""
    removed_files=""

    # Get the list of added, modified, and removed files in the commit
    while IFS= read -r line; do
        case "$line" in
            A*) added_files+="* $(echo "$line" | cut -c3-)\n";;
            M*) modified_files+="* $(echo "$line" | cut -c3-)\n";;
            D*) removed_files+="* $(echo "$line" | cut -c3-)\n";;
        esac
    done < <(git diff --cached --name-status)

    # Construct the changelog
    changelog="$header"
    if [ -n "$added_files" ]; then
        changelog+="### Added\n$added_files\n"
    fi
    if [ -n "$modified_files" ]; then
        changelog+="### Modified\n$modified_files\n"
    fi
    if [ -n "$removed_files" ]; then
        changelog+="### Removed\n$removed_files\n"
    fi

    # Append the changelog to CHANGELOG.md
    echo -e "$changelog" >>CHANGELOG.md

    # Create tag
    git tag -a "v$new_version" -m "Version $new_version"
}

# Call the function to generate changelog and create tag
generate_changelog_and_tag

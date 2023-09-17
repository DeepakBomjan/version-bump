#!/bin/bash

# Usage: ./calculate_next_semver.sh current_version bump_type

current_version="$1"
bump_type="$2"

# Function to split version string into an array
function split_version {
  IFS='.' read -ra version_parts <<< "$1"
}

# Function to join array elements into a string
function join_array {
  local IFS="$1"
  shift
  echo "$*"
}

# Validate bump type
if [[ ! "$bump_type" =~ ^(patch|minor|major)$ ]]; then
  echo "Error: Invalid bump type. Use 'patch', 'minor', or 'major'."
  exit 1
fi

# Split the current version into an array
split_version "$current_version"

# Calculate the next version
case "$bump_type" in
  patch)
    ((version_parts[2]++))
    ;;
  minor)
    ((version_parts[1]++))
    version_parts[2]=0
    ;;
  major)
    ((version_parts[0]++))
    version_parts[1]=0
    version_parts[2]=0
    ;;
  *)
    echo "Error: Invalid bump type. Use 'patch', 'minor', or 'major'."
    exit 1
    ;;
esac

# Join the array elements back into the next version string
next_version=$(join_array '.' "${version_parts[@]}")

echo "Current version: $current_version"
echo "Bump type: $bump_type"
echo "Next version: $next_version"


#!/bin/bash

BOM_JSON="/opt/ghidra/bom.json"

# Ensure required tools
for tool in jq curl dpkg; do
  if ! command -v $tool >/dev/null; then
    echo "Error: $tool is required but not installed."
    exit 1
  fi
done

# Get local version
local_version=$(jq -r '.components[] | select(.name=="Public_Release") | .version' "$BOM_JSON")
if [ -z "$local_version" ]; then
  echo "Error: Could not find Public_Release component in bom.json"
  exit 1
fi

# Get latest GitHub release name and clean to just version
latest_release_name=$(curl -s https://api.github.com/repos/NationalSecurityAgency/ghidra/releases/latest |
  jq -r '.name' | grep -oE '[0-9]+(\.[0-9]+)*')
if [ -z "$latest_release_name" ]; then
  echo "Error: Could not parse version from latest GitHub release name"
  exit 1
fi

# Output versions
echo "Local version:  $local_version"
echo "Latest version: $latest_release_name"

# Compare versions using dpkg
if dpkg --compare-versions "$local_version" lt "$latest_release_name"; then
  echo "Update available!"
  tempdir=$(mktemp -d)
  cd $tempdir
  curl -s https://api.github.com/repos/NationalSecurityAgency/ghidra/releases/latest |\
  jq -r '.assets[] | select(.name | test("^ghidra.*\\.zip$")) | .browser_download_url' |\
  xargs -n 1 curl -L -o ghidra_update.zip
  unzip ghidra_update.zip
  sudo cp -a ghidra*/. /opt/ghidra/
  echo "Update complete!"
elif dpkg --compare-versions "$local_version" gt "$latest_release_name"; then
  echo "Local version is newer than GitHub release."
else
  echo "You are up to date."
fi
